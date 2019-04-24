ARG alpine_version=latest
ARG ubuntu_version=latest

FROM alpine:${alpine_version} AS download
RUN apk add --no-cache git
RUN git clone --single-branch --branch master https://github.com/rhoriguchi/myanimelist-export.git /myanimelist-export

FROM ubuntu:${ubuntu_version} AS install_stack
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
	ca-certificates \
	curl \
    g++ \
    gcc \
    git \
    gnupg \
    libffi-dev \
    libgmp-dev \
    make \
    netbase \
    xz-utils \
    zlib1g-dev \
	&& apt-get clean \
 	&& rm -rf /var/lib/apt/lists/*
ADD https://get.haskellstack.org haskell_install.sh
RUN chmod +x haskell_install.sh \
	&& ./haskell_install.sh

FROM install_stack AS build
COPY --from=download /myanimelist-export /myanimelist-export
RUN stack init /myanimelist-export
RUN stack build /myanimelist-export
RUN stack install /myanimelist-export

FROM ubuntu:${ubuntu_version}
LABEL maintainer="ryan.horiguchi@gmail.com"
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
	ca-certificates \
	cron \
	netbase \
	&& apt-get clean \
 	&& rm -rf /var/lib/apt/lists/*
COPY --from=build /root/.local/bin/myanimelist-export /myanimelist-export
RUN chmod +x /myanimelist-export
COPY myanimelist-export.yaml /root/.config/myanimelist-export.yaml
COPY myanimelist-export.sh /myanimelist-export.sh
RUN sed -i '1s/^.*#//;s/\r$//' /myanimelist-export.sh \
    && chmod +x /myanimelist-export.sh
RUN echo "0    4       *       *       *       /myanimelist-export.sh" >> /etc/cron.d/myanimelist-export \
	&& crontab /etc/cron.d/myanimelist-export
RUN mkdir /export
VOLUME /export
CMD ["cron", "-f"]

# TODO use cron container
