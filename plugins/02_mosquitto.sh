set -e

COMMAND="$1"

banner() {
    echo "---------------------------------------------------"
    echo "$*"
    echo "---------------------------------------------------"
}

mosquitto_journal() {
    if command -V journalctl >/dev/null 2>&1; then
        banner "mosquitto journal"
        journalctl -u "mosquitto" -n 1000 2>&1 ||:
    fi
}

mosquitto_log() {
    if [ -f /var/log/mosquitto/mosquitto.log ]; then 
        banner "mosquitto.log"
        cat /var/log/mosquitto/mosquitto.log
    else
        echo "mosquitto.log not found" >&2
    fi
}

collect() {
    if [ "$(tedge config get mqtt.bridge.built_in)" = "false" ]; then
        if command -V mosquitto > /dev/null 2>&1; then
            mosquitto_journal
            mosquitto_log
        else
            echo "mosquitto not found" >&2
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
