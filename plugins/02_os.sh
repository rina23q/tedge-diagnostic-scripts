#!/bin/sh
set -e

OUTPUT_DIR=""
COMMAND=""

# Parse arguments
while [ $# -gt 0 ]; do
    case "$1" in
        --output-dir)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        collect)
            COMMAND="collect"
            shift
            ;;
        *)
            echo "Unknown command: $1" >&2
            exit 1
            ;;
    esac
done

collect() {
    if [ -f /etc/os-release ]; then
        echo "/etc/os-release"
        cat /etc/os-release
    fi

    echo "system information"
    uname -a
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
