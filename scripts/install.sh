#!/usr/bin/env bash
set -Eeuo pipefail

PREFIX="/opt/mainsail-marlin"
SERIAL_GROUP=""
DRY_RUN=0
LOG_FILE=""

usage() {
    printf 'Usage: %s [--prefix PATH] [--serial-group GROUP] [--dry-run]\n' "$0"
}

log() {
    printf '[mainsail-marlin] %s\n' "$*"
}

die() {
    printf '[mainsail-marlin] ERROR: %s\n' "$*" >&2
    exit 1
}

run() {
    if ((DRY_RUN)); then
        printf '+ %q' "$1"
        shift
        printf ' %q' "$@"
        printf '\n'
    else
        "$@"
    fi
}

node_is_compatible() {
    command -v node >/dev/null 2>&1 || return 1
    node -e '
        const [major, minor] = process.versions.node.split(".").map(Number);
        process.exit(
            major > 22 || (major === 22 && minor >= 12) ||
            (major === 20 && minor >= 19) ? 0 : 1
        );
    ' >/dev/null 2>&1
}

install_system_dependencies() {
    command -v apt-get >/dev/null 2>&1 ||
        die "automatic dependency installation currently requires Debian/Ubuntu with apt-get"

    if ((DRY_RUN)); then
        log "dry-run: would install system dependencies: ca-certificates curl git build-essential python3 nginx libudev-dev"
        if ! node_is_compatible; then
            log "dry-run: would install Node.js 22 because a compatible Node.js version is not available"
        fi
        return
    fi

    log "installing system dependencies"
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        ca-certificates curl git build-essential python3 nginx libudev-dev

    if ! node_is_compatible; then
        log "installing Node.js 22"
        curl --fail --silent --show-error --location https://deb.nodesource.com/setup_22.x |
            bash -
        apt-get install -y nodejs
    fi

    if ! command -v npm >/dev/null 2>&1; then
        log "installing npm"
        apt-get install -y npm
    fi
}

while (($#)); do
    case "$1" in
        --prefix) (($# >= 2)) || die "--prefix requires a path"; PREFIX="$2"; shift 2 ;;
        --serial-group) (($# >= 2)) || die "--serial-group requires a group"; SERIAL_GROUP="$2"; shift 2 ;;
        --dry-run) DRY_RUN=1; shift ;;
        -h|--help) usage; exit 0 ;;
        *) die "unknown argument: $1" ;;
    esac
done

[[ "$PREFIX" = /* && "$PREFIX" != "/" && "$PREFIX" != /tmp && "$PREFIX" != /tmp/* ]] ||
    die "refusing unsafe prefix: $PREFIX"

if [[ ${EUID:-$(id -u)} -ne 0 && $DRY_RUN -eq 0 ]]; then
    die "run as root for a real installation, or use --dry-run"
fi

install_system_dependencies

if ((DRY_RUN)); then
    log "dry-run: prerequisites and dependency installation plan passed; no files or services will be changed"
    exit 0
fi

command -v node >/dev/null || die "node installation failed"
command -v npm >/dev/null || die "npm installation failed"
command -v systemctl >/dev/null || die "systemctl is required"
node_is_compatible || die "Node.js 20.19+ or 22.12+ is required"

STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
BACKUP="${PREFIX}.backup.${STAMP}"
if [[ -e "$PREFIX" ]]; then
    log "creating backup at $BACKUP"
    cp -a -- "$PREFIX" "$BACKUP"
fi

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"
if ! getent passwd mainsail >/dev/null; then
    useradd --system --home-dir /var/lib/mainsail-marlin --create-home \
        --shell /usr/sbin/nologin mainsail
fi
install -d -o mainsail -g mainsail -m 0750 /var/lib/mainsail-marlin
mkdir -p -- "$PREFIX"
cp -a -- "$ROOT_DIR/mainsail-marlin" "$PREFIX/"
cp -a -- "$ROOT_DIR/marlinraker-marlin" "$PREFIX/"
mkdir -p -- "$PREFIX/data" "$PREFIX/logs"
chown -R mainsail:mainsail -- "$PREFIX/data" "$PREFIX/logs"

log "installing frontend dependencies and build"
(cd "$PREFIX/mainsail-marlin" && npm ci && npm run build)
log "installing backend dependencies and build"
(cd "$PREFIX/marlinraker-marlin" && npm ci && npm run build)

if [[ -n "$SERIAL_GROUP" ]]; then
    getent group "$SERIAL_GROUP" >/dev/null || die "serial group does not exist: $SERIAL_GROUP"
    usermod -a -G "$SERIAL_GROUP" mainsail
    log "added mainsail user to serial group: $SERIAL_GROUP"
fi

install -d -m 0755 /etc/mainsail-marlin
install -m 0644 "$ROOT_DIR/deploy/mainsail-marlin.service" /etc/systemd/system/mainsail-marlin.service
install -m 0644 "$ROOT_DIR/deploy/nginx.conf" /etc/mainsail-marlin/nginx.conf
systemctl daemon-reload
systemctl enable mainsail-marlin.service
log "installation completed; service is enabled but not started automatically"
