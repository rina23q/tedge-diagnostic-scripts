#!/bin/sh
set -e

COMMAND="$1"

banner() {
    echo "---------------------------------------------------"
    echo "$*"
    echo "---------------------------------------------------"
}

collect() {
    echo "00_tedge"

    # tedge-agent
    banner "tedge-agent"
    if command -V journalctl >/dev/null 2>&1; then
        journalctl -u tedge-agent -n 1000 --no-pager 2>&1 ||:
    fi

    # mappers
    MAPPERS="c8y az aws"
    for mapper in $MAPPERS; do
        if tedge config get "${mapper}.url" >/dev/null 2>&1; then
            if command -V journalctl >/dev/null 2>&1; then
            banner "tedge-mapper-${mapper}"
                journalctl -u "tedge-mapper-${mapper}" -n 1000 --no-pager 2>&1 ||:
            fi
        fi
    done
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
