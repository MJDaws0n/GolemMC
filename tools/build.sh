#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
: "${NOVUS_ROOT:?Set NOVUS_ROOT to the self-hosted Novus checkout with native_call support}"
NOVUS_ROOT=$(cd "$NOVUS_ROOT" && pwd)
NOVUS_BIN=${NOVUS_BIN:-"$NOVUS_ROOT/build/darwin_arm64/novus"}
if [ ! -x "$NOVUS_BIN" ]; then
    printf '%s\n' "Build the self-hosted Novus checkout or set NOVUS_BIN to its compiler." >&2
    exit 1
fi
for library in std file_io; do
    if [ ! -e "lib/$library" ]; then
        ln -s "$NOVUS_ROOT/lib/$library" "lib/$library"
    fi
done
exec "$NOVUS_BIN" --heap-size=512m --gc-entries=262144 "${1:-main.nov}"
