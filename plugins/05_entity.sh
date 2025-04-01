#!/bin/sh
set -e

COMMAND="$1"
LOG_PATH="$(tedge config get logs.path)"

collect() {
    if command -V tedge > /dev/null 2>&1; then
        tedge http get /tedge/entity-store/v1/entities
    fi
}


case "$COMMAND" in
    collect)
        collect
        ;;
    *)
        echo "Unknown command" >&2
        exit 1
        ;;
esac

exit 0
