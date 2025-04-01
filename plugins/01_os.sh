#!/bin/sh
set -e

collect() {
    if [ -f /etc/os-release ]; then
        echo "file: /etc/os-release"
        cat /etc/os-release
    fi

    echo "system information"
    uname -a
}


case "$1" in
    collect) collect ;;
    *)
        echo "Unknown command" >&2
        exit 1
        ;;
esac
