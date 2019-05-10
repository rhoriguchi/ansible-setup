ARG ubuntu_version=latest

FROM ubuntu:${ubuntu_version}
LABEL maintainer="ryan.horiguchi@gmail.com"
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
	gpg \
	gpg-agent \
	wget \
	&& apt-get clean \
 	&& rm -rf /var/lib/apt/lists/*
RUN echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" | tee /etc/apt/sources.list.d/resilio-sync.list \
	&& wget -qO - http://linux-packages.resilio.com/resilio-sync/key.asc | apt-key add - \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends resilio-sync \
	&& apt-get clean \
 	&& rm -rf /var/lib/apt/lists/*
RUN mkdir /sync \
	&& mkdir /downloads \
	&& mkdir /config
COPY config.json /etc/resilio-sync/config.json
VOLUME /sync /downloads /config
EXPOSE 55555 8888
CMD ["/usr/bin/rslsync", "--config", "/etc/resilio-sync/config.json", "--nodaemon"]
