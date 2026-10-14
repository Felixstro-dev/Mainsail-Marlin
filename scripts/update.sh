#!/usr/bin/env bash
set -Eeuo pipefail

PREFIX="/opt/mainsail-marlin"
SOURCE_DIR=""
DRY_RUN=0

die() { printf '[mainsail-marlin] ERROR: %s\n' "$*" >&2; exit 1; }
while (($#)); do
    case "$1" in
        --prefix) (($# >= 2)) || die "--prefix requires a path"; PREFIX="$2"; shift 2 ;;
        --source-dir) (($# >= 2)) || die "--source-dir requires a path"; SOURCE_DIR="$2"; shift 2 ;;
        --dry-run) DRY_RUN=1; shift ;;
        -h|--help) printf 'Usage: %s [--prefix PATH] [--source-dir PATH] [--dry-run]\n' "$0"; exit 0 ;;
        *) die "unknown argument: $1" ;;
    esac
done
[[ "$PREFIX" = /* && "$PREFIX" != "/" && "$PREFIX" != /tmp && "$PREFIX" != /tmp/* ]] ||
    die "refusing unsafe prefix: $PREFIX"
[[ -d "$PREFIX/mainsail-marlin" && -d "$PREFIX/marlinraker-marlin" ]] ||
    die "installation not found at $PREFIX"
if [[ -n "$SOURCE_DIR" ]]; then
    [[ -d "$SOURCE_DIR/mainsail-marlin" && -d "$SOURCE_DIR/marlinraker-marlin" ]] ||
        die "update source is incomplete: $SOURCE_DIR"
fi
[[ ${EUID:-$(id -u)} -eq 0 || $DRY_RUN -eq 1 ]] || die "run as root for a real update"
command -v npm >/dev/null || die "npm is required"
command -v systemctl >/dev/null || die "systemctl is required"

STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
BACKUP="${PREFIX}.backup.${STAMP}"
if ((DRY_RUN)); then
    printf '[mainsail-marlin] dry-run: would backup %s to %s, replace sources, and rebuild both projects\n' "$PREFIX" "$BACKUP"
    exit 0
fi

cp -a -- "$PREFIX" "$BACKUP"
systemctl stop mainsail-marlin.service 2>/dev/null || true
if [[ -n "$SOURCE_DIR" ]]; then
    rm -rf -- "$PREFIX/mainsail-marlin" "$PREFIX/marlinraker-marlin"
    cp -a -- "$SOURCE_DIR/mainsail-marlin" "$SOURCE_DIR/marlinraker-marlin" "$PREFIX/"
fi
(cd "$PREFIX/mainsail-marlin" && npm ci && npm run build)
(cd "$PREFIX/marlinraker-marlin" && npm ci && npm run build)
systemctl start mainsail-marlin.service
systemctl is-active --quiet mainsail-marlin.service || die "service did not become active; backup: $BACKUP"
if command -v nginx >/dev/null 2>&1; then
    nginx -t
    systemctl reload nginx
fi
printf '[mainsail-marlin] update completed; backup: %s\n' "$BACKUP"
