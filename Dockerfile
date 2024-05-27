FROM curlimages/curl:8.8.0

COPY self-heal.sh /self-heal.sh

CMD ["/bin/sh"]

#checkov:skip=CKV_DOCKER_2:We don't need Docker HEALTHCHECK in Kubernetes
#checkov:skip=CKV_DOCKER_3:Image inherits curl_user form base image

ENTRYPOINT ["/self-heal.sh"]
