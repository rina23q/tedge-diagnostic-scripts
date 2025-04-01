#!/bin/sh
set -e

COMMAND="$1"
LOG_PATH="$(tedge config get logs.path)"

banner() {
    echo "---------------------------------------------------"
    echo "$*"
    echo "---------------------------------------------------"
}

collect() {
    if [ -d "$LOG_PATH"/agent ]; then
        for file in "$LOG_PATH"/agent/*; do
            banner $file
            cat "$file"
        done
    else 
        echo "${LOG_PATH} not found" >&2
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
