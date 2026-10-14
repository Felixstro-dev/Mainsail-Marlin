#!/usr/bin/env bash
set -Eeuo pipefail

PREFIX="/opt/mainsail-marlin"
while (($#)); do
    case "$1" in
        --prefix) (($# >= 2)) || { printf 'ERROR: --prefix requires a path\n' >&2; exit 1; }; PREFIX="$2"; shift 2 ;;
        -h|--help) printf 'Usage: %s [--prefix PATH]\n' "$0"; exit 0 ;;
        *) printf 'ERROR: unknown argument: %s\n' "$1" >&2; exit 1 ;;
    esac
done

printf '%s\n' 'Mainsail-Marlin diagnostic (secrets omitted)'
printf 'OS: '; uname -srm
printf 'Architecture: '; dpkg --print-architecture 2>/dev/null || uname -m
printf 'Node: '; node --version 2>/dev/null || printf 'not found\n'
printf 'npm: '; npm --version 2>/dev/null || printf 'not found\n'
printf 'Prefix: %s\n' "$PREFIX"
printf 'Frontend: '; [[ -d "$PREFIX/mainsail-marlin" ]] && printf 'present\n' || printf 'missing\n'
printf 'Backend: '; [[ -d "$PREFIX/marlinraker-marlin" ]] && printf 'present\n' || printf 'missing\n'
printf 'Service: '; systemctl is-active mainsail-marlin.service 2>/dev/null || printf 'inactive or unavailable\n'
printf 'Serial devices:\n'
find /dev/serial/by-id -maxdepth 1 -type l -printf '  %f\n' 2>/dev/null || printf '  none or permission denied\n'
