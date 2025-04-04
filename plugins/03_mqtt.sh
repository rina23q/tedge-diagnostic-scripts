#!/bin/sh
set -e

COMMAND="$1"

banner() {
    echo "---------------------------------------------------"
    echo "$*"
    echo "---------------------------------------------------"
}

collect() {
    if command -V tedge > /dev/null 2>&1; then
        banner "tedge mqtt sub '#' --duration 5s"
        tedge mqtt sub '#' --duration 5s
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
