FROM curlimages/curl:8.1.0

COPY self-heal.sh /self-heal.sh

CMD ["/bin/sh"]

ENTRYPOINT ["/self-heal.sh"]
