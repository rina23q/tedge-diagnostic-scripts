#!/bin/sh

call_collect() {
    TIMESTAMP=$(date +"%Y%m%d%H%M%S")
    PLUGIN_DIR="$1"
    DIAG_DIR=""$2"/tedge-diagnostic-$TIMESTAMP"

    if [ ! -d "$PLUGIN_DIR" ]; then
        echo "Error: Directory '$PLUGIN_DIR' does not exist." >&2
        exit 1
    fi

    mkdir -p "$DIAG_DIR"

    for file in "$PLUGIN_DIR"/*; do
        if [ -f "$file" ]; then
            "$file" collect > "$DIAG_DIR/$(basename "$file")_output.txt" 2>&1
            "$file" collect
        fi
    done
}

PLUGIN_DIR="./plugins"
OUTPUT_DIR="./output"


while [ "$#" -gt 0 ]; do
    case "$1" in
        --plugin-dir)
            if [ -n "$2" ]; then
                PLUGIN_DIR="$2"
                shift
            else
                echo "Error: --plugin-dir requires an argument" >&2
                exit 1
            fi
            ;;
        --output-dir)
            if [ -n "$2" ]; then
                OUTPUT_DIR="$2"
                shift
            else
                echo "Error: --output-dir requires an argument" >&2
                exit 1
            fi
            ;;
        *)
            echo "Error: Unknown argument: $1" >&2
            exit 1
            ;;
    esac
    shift
done

call_collect "$PLUGIN_DIR" "$OUTPUT_DIR"
