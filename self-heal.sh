#!/bin/sh
#
# patroni self heal
#

trap exit TERM INT

while true; do
    echo "$(date +'%d.%m.%Y %H:%M:%S') - Checking Patroni health..."

    if curl -s localhost:8008 | grep -q '"state": "start failed"'; then
        echo "$(date +'%d.%m.%Y %H:%M:%S') - Patroni start failed :("
        echo "$(date +'%d.%m.%Y %H:%M:%S') - Deleting pod..."
        curl -k -X DELETE "https://${KUBERNETES_SERVICE_HOST}:${KUBERNETES_PORT_443_TCP_PORT}/api/v1/namespaces/${POD_NAMESPACE}/pods/${POD_NAME}" --data '{"gracePeriodSeconds":0,"propagationPolicy":"Background"}' -H "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" -H "Accept: application/json" -H "Content-Type: application/json"
        exit 1
    fi

    echo "$(date +'%d.%m.%Y %H:%M:%S') - Patroni health OK :)"
    sleep 60

done
