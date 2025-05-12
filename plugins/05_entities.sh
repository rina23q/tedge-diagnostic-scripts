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
    if command -V tedge > /dev/null 2>&1; then
        echo "tedge http get /te/v1/entities"
            if command -V jq > /dev/null 2>&1; then
                tedge http get /te/v1/entities | jq
            else
                tedge http get /te/v1/entities
            fi
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
