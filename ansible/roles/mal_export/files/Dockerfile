ARG alpine_version=latest
ARG ubuntu_version=latest

FROM alpine:${alpine_version} AS download
RUN apk add --no-cache git
RUN git clone --single-branch --branch master https://github.com/rhoriguchi/myanimelist-export.git /myanimelist-export

FROM ubuntu:${ubuntu_version} AS install_haskell
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
	ca-certificates \
    g++ \
    gcc \
    git \
    gnupg \
    libffi-dev \
    libgmp-dev \
    make \
    netbase \
    wget \
    xz-utils \
    zlib1g-dev \
	&& apt-get clean \
 	&& rm -rf /var/lib/apt/lists/*
RUN wget -qO haskell_install.sh https://get.haskellstack.org \
    && chmod +x haskell_install.sh \
	&& sh haskell_install.sh \
	&& rm -f haskell_install.sh

FROM install_haskell AS build
RUN apt-get update \
	&& apt-get install -y --no-install-recommends ghc \
	&& apt-get clean \
 	&& rm -rf /var/lib/apt/lists/*
RUN stack config set system-ghc --global true
COPY --from=download /myanimelist-export /myanimelist-export
RUN stack init /myanimelist-export
RUN stack build /myanimelist-export
RUN stack install /myanimelist-export

FROM ubuntu:${ubuntu_version} AS base
LABEL maintainer="ryan.horiguchi@gmail.com"
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
	ca-certificates \
	libatomic1 \
	netbase \
	&& apt-get clean \
 	&& rm -rf /var/lib/apt/lists/*
COPY --from=build /root/.local/bin/myanimelist-export /myanimelist-export
COPY myanimelist-export.sh /myanimelist-export.sh
RUN sed -i '1s/^.*#//;s/\r$//' /myanimelist-export.sh \
    && chmod +x /myanimelist-export.sh \
    && chmod +x /myanimelist-export
COPY myanimelist-export.yaml /root/.config/myanimelist-export.yaml
RUN mkdir /export
VOLUME /export
CMD ["/bin/bash", "/myanimelist-export.sh"]

FROM base AS cronjob
RUN apt-get update \
	&& apt-get install -y --no-install-recommends cron \
	&& apt-get clean \
 	&& rm -rf /var/lib/apt/lists/*
RUN echo "0    4       *       *       *       /myanimelist-export.sh >> /mal_export.log 2>&1" >> /etc/cron.d/myanimelist-export \
	&& crontab /etc/cron.d/myanimelist-export
CMD ["cron", "-f"]
