#!/usr/bin/env bash
set -Eeuo pipefail

PREFIX="/opt/mainsail-marlin"
DRY_RUN=0

die() { printf '[mainsail-marlin] ERROR: %s\n' "$*" >&2; exit 1; }
while (($#)); do
    case "$1" in
        --prefix) (($# >= 2)) || die "--prefix requires a path"; PREFIX="$2"; shift 2 ;;
        --dry-run) DRY_RUN=1; shift ;;
        -h|--help) printf 'Usage: %s [--prefix PATH] [--dry-run]\n' "$0"; exit 0 ;;
        *) die "unknown argument: $1" ;;
    esac
done
[[ "$PREFIX" = /* && "$PREFIX" != "/" && "$PREFIX" != /tmp && "$PREFIX" != /tmp/* ]] ||
    die "refusing unsafe prefix: $PREFIX"
[[ -d "$PREFIX/mainsail-marlin" && -d "$PREFIX/marlinraker-marlin" ]] ||
    die "installation not found at $PREFIX"
[[ ${EUID:-$(id -u)} -eq 0 || $DRY_RUN -eq 1 ]] || die "run as root for a real update"

STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
BACKUP="${PREFIX}.backup.${STAMP}"
if ((DRY_RUN)); then
    printf '[mainsail-marlin] dry-run: would backup %s to %s and rebuild both projects\n' "$PREFIX" "$BACKUP"
    exit 0
fi

cp -a -- "$PREFIX" "$BACKUP"
systemctl stop mainsail-marlin.service 2>/dev/null || true
(cd "$PREFIX/mainsail-marlin" && npm ci && npm run build)
(cd "$PREFIX/marlinraker-marlin" && npm ci && npm run build)
systemctl start mainsail-marlin.service
systemctl is-active --quiet mainsail-marlin.service || die "service did not become active; backup: $BACKUP"
printf '[mainsail-marlin] update completed; backup: %s\n' "$BACKUP"
