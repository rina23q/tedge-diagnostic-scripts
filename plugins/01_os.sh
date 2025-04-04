#!/bin/sh
set -e

banner() {
    echo "---------------------------------------------------"
    echo "$*"
    echo "---------------------------------------------------"
}

collect() {
    if [ -f /etc/os-release ]; then
        banner "/etc/os-release"
        cat /etc/os-release
    fi

    banner "system information"
    uname -a
}


case "$1" in
    collect) collect ;;
    *)
        echo "Unknown command" >&2
        exit 1
        ;;
esac
