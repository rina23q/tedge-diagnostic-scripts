#!/bin/sh
set -e

COMMAND="$1"
LOGS_PATH="$(tedge config get logs.path)"

banner() {
    echo "---------------------------------------------------"
    echo "$*"
    echo "---------------------------------------------------"
}

collect() {
    if [ -d "$LOGS_PATH"/agent ]; then
        for file in "$LOGS_PATH"/agent/*; do
            banner "$file"
            cat "$file"
        done
    else 
        echo "${LOGS_PATH} not found" >&2
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
