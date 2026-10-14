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

command -v node >/dev/null || die "node is required"
command -v npm >/dev/null || die "npm is required"
command -v systemctl >/dev/null || die "systemctl is required"

if ((DRY_RUN)); then
    log "dry-run: prerequisites passed; no files or services will be changed"
    exit 0
fi

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
