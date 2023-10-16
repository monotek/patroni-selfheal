FROM curlimages/curl:8.4.0

COPY self-heal.sh /self-heal.sh

CMD ["/bin/sh"]

ENTRYPOINT ["/self-heal.sh"]
