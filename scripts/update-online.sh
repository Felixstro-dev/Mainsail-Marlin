#!/usr/bin/env bash
set -Eeuo pipefail

REPOSITORY="https://codeload.github.com/Felixstro-dev/Mainsail-Marlin"
REF="${MAINSAIL_MARLIN_REF:-master}"
PREFIX="${MAINSAIL_MARLIN_PREFIX:-/opt/mainsail-marlin}"
TEMP_DIR="$(mktemp -d)"

cleanup() {
    rm -rf -- "$TEMP_DIR"
}
trap cleanup EXIT

die() {
    printf '[mainsail-marlin] ERROR: %s\n' "$*" >&2
    exit 1
}

command -v curl >/dev/null 2>&1 || die "curl is required"
command -v tar >/dev/null 2>&1 || die "tar is required"

ARCHIVE="$TEMP_DIR/mainsail-marlin.tar.gz"
curl --fail --silent --show-error --location \
    "$REPOSITORY/tar.gz/refs/heads/$REF" \
    --output "$ARCHIVE"
tar -xzf "$ARCHIVE" -C "$TEMP_DIR"
SOURCE_DIR="$(find "$TEMP_DIR" -mindepth 1 -maxdepth 1 -type d -name 'Mainsail-Marlin-*' -print -quit)"
[[ -n "$SOURCE_DIR" ]] || die "downloaded archive did not contain the project"

if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
    for argument in "$@"; do
        if [[ "$argument" == "--dry-run" ]]; then
            exec bash "$SOURCE_DIR/scripts/update.sh" \
                --prefix "$PREFIX" --source-dir "$SOURCE_DIR" "$@"
        fi
    done
    command -v sudo >/dev/null 2>&1 || die "sudo is required when not running as root"
    exec sudo bash "$SOURCE_DIR/scripts/update.sh" \
        --prefix "$PREFIX" --source-dir "$SOURCE_DIR" "$@"
fi

exec bash "$SOURCE_DIR/scripts/update.sh" \
    --prefix "$PREFIX" --source-dir "$SOURCE_DIR" "$@"
