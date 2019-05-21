ARG python_version=alpine

FROM python:${python_version}
RUN pip install \
    flexget \
    transmissionrpc
VOLUME /config
EXPOSE 5050
CMD ["/usr/local/bin/flexget", "daemon", "start", "-d"]
