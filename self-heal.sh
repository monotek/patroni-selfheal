#!/bin/sh
#
# patroni self heal
#

set -e

SLEEP_TIME="60"

trap exit TERM INT

log() {
	echo "$(date +'%d.%m.%Y %H:%M:%S') - ${1}"
}

deletepod() {
	log "Deleting pod ${POD_NAME} in namespace ${POD_NAMESPACE}!"
	echo "${PATRONI_STATE}" | jq
	curl -k -X DELETE "https://${KUBERNETES_SERVICE_HOST}:${KUBERNETES_PORT_443_TCP_PORT}/api/v1/namespaces/${POD_NAMESPACE}/pods/${POD_NAME}" -H "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" -H "Accept: application/json" -H "Content-Type: application/json"
	exit 1
}

log "Checking Patroni health every ${SLEEP_TIME} seconds..."

while true; do
	sleep "${SLEEP_TIME}"

	PATRONI_STATE="$(curl -s localhost:8008)"

	if [ -z "${PATRONI_STATE}" ]; then
		log "Patroni state empty :("
		exit 1
	elif [ -n "$(echo "${PATRONI_STATE}" | jq 'select(.state == "start failed")')" ]; then
		log "Patroni start failed :("
		deletepod
	elif [ -n "$(echo "${PATRONI_STATE}" | jq 'select(.role == "replica") | select(.replication_state == "running")')" ]; then
		log "Patroni replica not streaming :("
		deletepod
	fi

	log "Patroni health OK :)"
done
