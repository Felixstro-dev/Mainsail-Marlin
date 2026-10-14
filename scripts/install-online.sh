#!/usr/bin/env bash
set -Eeuo pipefail

REPOSITORY="https://github.com/Felixstro-dev/Mainsail-Marlin"
REF="${MAINSAIL_MARLIN_REF:-master}"
TEMP_DIR="$(mktemp -d)"

cleanup() {
    rm -rf -- "$TEMP_DIR"
}
trap cleanup EXIT

log() {
    printf '[mainsail-marlin] %s\n' "$*"
}

die() {
    printf '[mainsail-marlin] ERROR: %s\n' "$*" >&2
    exit 1
}

command -v curl >/dev/null 2>&1 || die "curl is required"
command -v tar >/dev/null 2>&1 || die "tar is required"

ARCHIVE="$TEMP_DIR/mainsail-marlin.tar.gz"
log "downloading Mainsail-Marlin from $REPOSITORY ($REF)"
curl --fail --silent --show-error --location \
    "$REPOSITORY/archive/refs/heads/$REF.tar.gz" \
    --output "$ARCHIVE"

tar -xzf "$ARCHIVE" -C "$TEMP_DIR"
SOURCE_DIR="$(find "$TEMP_DIR" -mindepth 1 -maxdepth 1 -type d -name 'Mainsail-Marlin-*' -print -quit)"
[[ -n "$SOURCE_DIR" ]] || die "downloaded archive did not contain the project"

if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
    for argument in "$@"; do
        if [[ "$argument" == "--dry-run" ]]; then
            exec bash "$SOURCE_DIR/scripts/install.sh" "$@"
        fi
    done
    command -v sudo >/dev/null 2>&1 || die "sudo is required when not running as root"
    exec sudo bash "$SOURCE_DIR/scripts/install.sh" "$@"
fi

exec bash "$SOURCE_DIR/scripts/install.sh" "$@"
