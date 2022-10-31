FROM curlimages/curl:7.86.0

COPY self-heal.sh /self-heal.sh

CMD ["/bin/sh"]

ENTRYPOINT ["/self-heal.sh"]
