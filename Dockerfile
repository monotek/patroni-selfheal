FROM curlimages/curl:8.17.0

USER root
# hadolint ignore=DL3018
RUN  apk add --no-cache jq
USER curl_user

COPY self-heal.sh /self-heal.sh

CMD ["/bin/sh"]

#checkov:skip=CKV_DOCKER_2:We don't need Docker HEALTHCHECK in Kubernetes

ENTRYPOINT ["/self-heal.sh"]
