ARG alpine_version=latest
ARG haskell_version=latest

FROM alpine:${alpine_version} AS download
RUN apk add --no-cache git
RUN git clone --single-branch --branch master https://github.com/rhoriguchi/myanimelist-export.git /myanimelist-export

FROM haskell:${haskell_version} AS build
COPY --from=download /myanimelist-export /myanimelist-export
RUN stack install /myanimelist-export

FROM haskell:${haskell_version}
LABEL maintainer="ryan.horiguchi@gmail.com"
RUN apt-get update \
	&& apt-get install -y --no-install-recommends cron \
	&& apt-get clean \
 	&& rm -rf /var/lib/apt/lists/*
COPY --from=build /root/.local/bin/myanimelist-export /myanimelist-export
RUN chmod +x /myanimelist-export
COPY myanimelist-export.yaml /root/.config/myanimelist-export.yaml
COPY myanimelist-export.sh /myanimelist-export.sh
RUN sed -i '1s/^.*#//;s/\r$//' /myanimelist-export.sh \
    && chmod +x /myanimelist-export.sh
RUN crontab -l | { cat; echo "0    3       *       *       *       /myanimelist-export.sh"; } | crontab -
VOLUME /export
CMD ["cron", "-f"]
