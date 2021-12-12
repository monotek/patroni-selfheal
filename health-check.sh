#!/bin/bash
#
# patroni health-check
#

trap exit TERM INT

while true; do
    echo "Checking Patroni health..."

    if patronictl list --format=json | jq '.[] | select(.Member == "'"$(hostname)"'") | .State' | grep -q "start failed"; then
        echo "Patroni start failed :("
        echo "Restarting container..."
        exit 1
    fi

    echo "Patroni health OK :)"
    sleep 15

done
