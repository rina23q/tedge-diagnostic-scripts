set -e

COMMAND="$1"
CONFIG_DIR="/etc/tedge"

banner() {
    echo "---------------------------------------------------"
    echo "$*"
    echo "---------------------------------------------------"
}


entity_store() {
    if [ -f "$CONFIG_DIR"/.agent/entity_store.jsonl ]; then
        banner "$CONFIG_DIR"/.agent/entity_store.jsonl
        cat "$CONFIG_DIR"/.agent/entity_store.jsonl
    elif [ -f "$CONFIG_DIR"/.tedge-mapper-c8y/entity_store.jsonl ]; then
        banner "$CONFIG_DIR"/.tedge-mapper-c8y/entity_store.jsonl
        cat "$CONFIG_DIR"/.tedge-mapper-c8y/entity_store.jsonl
    else
        echo "entity_store.jsonl not found" >&2
    fi
}

collect() {
    entity_store
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
