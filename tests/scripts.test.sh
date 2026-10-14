#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
for script in "$ROOT"/scripts/*.sh; do
    bash -n "$script"
done

output="$("$ROOT/scripts/install.sh" --prefix /opt/mainsail-marlin-test --dry-run)"
grep -q 'dry-run' <<<"$output"
"$ROOT/scripts/uninstall.sh" --prefix /opt/mainsail-marlin-test --dry-run >/dev/null
printf 'script syntax and dry-run checks passed\n'
