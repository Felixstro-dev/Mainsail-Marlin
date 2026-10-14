#!/usr/bin/env bash
set -Eeuo pipefail

PREFIX="/opt/mainsail-marlin"
KEEP_DATA=1
DRY_RUN=0
die() { printf '[mainsail-marlin] ERROR: %s\n' "$*" >&2; exit 1; }
while (($#)); do
    case "$1" in
        --prefix) (($# >= 2)) || die "--prefix requires a path"; PREFIX="$2"; shift 2 ;;
        --remove-data) KEEP_DATA=0; shift ;;
        --dry-run) DRY_RUN=1; shift ;;
        -h|--help) printf 'Usage: %s [--prefix PATH] [--remove-data] [--dry-run]\n' "$0"; exit 0 ;;
        *) die "unknown argument: $1" ;;
    esac
done
[[ "$PREFIX" = /* && "$PREFIX" != "/" && "$PREFIX" != /tmp && "$PREFIX" != /tmp/* ]] ||
    die "refusing unsafe prefix: $PREFIX"
[[ ${EUID:-$(id -u)} -eq 0 || $DRY_RUN -eq 1 ]] || die "run as root"
if ((DRY_RUN)); then
    printf '[mainsail-marlin] dry-run: would remove service and project at %s; keep-data=%s\n' "$PREFIX" "$KEEP_DATA"
    exit 0
fi
systemctl disable --now mainsail-marlin.service 2>/dev/null || true
rm -f -- /etc/systemd/system/mainsail-marlin.service /etc/mainsail-marlin/nginx.conf
rm -f -- /etc/nginx/sites-enabled/mainsail-marlin
systemctl daemon-reload
if ((KEEP_DATA)); then
    [[ -d "$PREFIX/data" ]] && mv -- "$PREFIX/data" "${PREFIX}.data-preserved.$(date -u +%Y%m%dT%H%M%SZ)"
fi
rm -rf -- "$PREFIX"
printf '[mainsail-marlin] removed project and service; preserved data=%s\n' "$KEEP_DATA"
