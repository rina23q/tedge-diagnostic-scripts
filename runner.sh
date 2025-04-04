#!/bin/sh

print_help() {
    cat <<EOF
Usage: $0 <command> [options]

Commands:
  collect             Run all plugins and create a diagnostics tarball
  help                Show this help message and exit

Options (for 'collect' command):
  --plugin-dir DIR    Directory containing plugin scripts (default: ./plugins)
  --output-dir DIR    Directory to save diagnostic output (default: ./output)

Description:
  The 'collect' command runs all executable plugin scripts in the specified
  plugin directory with the 'collect' argument. It saves the output to files
  under a temporary directory and creates a tarball of the collected results.
EOF
}


collect() {
    TIMESTAMP=$(date +"%Y%m%d%H%M%S")
    PLUGIN_DIR="$1"
    OUTPUT_DIR="$2"
    TMP_DIR="$OUTPUT_DIR/tmp"
    TARBALL="tedge-diagnostics_$TIMESTAMP.tar.gz"

    if [ ! -d "$PLUGIN_DIR" ]; then
        echo "Error: Directory $PLUGIN_DIR does not exist." >&2
        exit 1
    fi

    mkdir -p "$TMP_DIR"

    # Collect all files
    for file in "$PLUGIN_DIR"/*; do
        if [ -f "$file" ]; then
            "$file" collect > "$TMP_DIR/$(basename "$file")_output.txt" 2>&1
        fi
    done

    # Make a tarball
    tar -czf "$OUTPUT_DIR/$TARBALL" -C "$TMP_DIR" .
    if [ $? -eq 0 ]; then
        echo "Tarball created: $OUTPUT_DIR/$TARBALL"
    else
        echo "Error: Failed to create tarball." >&2
        exit 1
    fi
}

# No arguments: show help
if [ "$#" -lt 1 ]; then
    print_help
    exit 1
fi

COMMAND="$1"
shift

case "$COMMAND" in
    collect)
        # Defaults
        PLUGIN_DIR="./plugins"
        OUTPUT_DIR="./output"

        # Parse options
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
                --help|-h)
                    print_help
                    exit 0
                    ;;
                *)
                    echo "Error: Unknown option: $1" >&2
                    echo "Use '$0 help' to see usage." >&2
                    exit 1
                    ;;
            esac
            shift
        done

        collect "$PLUGIN_DIR" "$OUTPUT_DIR"
        ;;
    help|--help|-h)
        print_help
        ;;
    *)
        echo "Error: Unknown command '$COMMAND'" >&2
        echo "Use '$0 help' to see usage." >&2
        exit 1
        ;;
esac