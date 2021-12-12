FROM registry.opensource.zalan.do/acid/spilo-13:2.1-p1

COPY health-check.sh /health-check.sh

CMD ["/bin/bash", "/health-check.sh"]
