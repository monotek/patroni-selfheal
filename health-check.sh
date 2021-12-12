#!/bin/bash
#
# patroni health-check
#

trap exit TERM INT

while true; do
    echo "Checking Patroni health..."

    if curl -s localhost:8008 | jq '.state' | grep -q "start failed"; then
        echo "Patroni start failed :("
        echo "Restarting container..."
        exit 1
    fi

    echo "Patroni health OK :)"
    sleep 15

done
