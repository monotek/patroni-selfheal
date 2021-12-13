#!/bin/bash
#
# patroni health-check
#

trap exit TERM INT

while true; do
    echo "Checking Patroni health..."

    if curl -s localhost:8008 | jq '.state' | grep -q "start failed"; then
        curl -X DELETE "https://${KUBERNETES_SERVICE_HOST}:${KUBERNETES_PORT_443_TCP_PORT}/api/v1/namespaces/${POD_NAMESPACE}/pods/$(hostname)" -k -H "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)"
    fi

    echo "Patroni health OK :)"
    sleep 15

done
