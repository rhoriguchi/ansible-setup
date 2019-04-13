FROM python:3.7.2-alpine AS download

LABEL maintainer="ryan.horiguchi@gmail.com"

RUN apk add --no-cache git

RUN git clone -b master https://github.com/rhoriguchi/myanimelist-export.git

FROM haskell:8.6.3 AS build

LABEL maintainer="ryan.horiguchi@gmail.com"

COPY --from=download /myanimelist-export /myanimelist-export

RUN stack setup --install-ghc

RUN stack init /myanimelist-export \
	&& stack build /myanimelist-export \
	&& stack install /myanimelist-export

FROM haskell:8.4.4

LABEL maintainer="ryan.horiguchi@gmail.com"

COPY --from=build /root/.local/bin/myanimelist-export /myanimelist-export

RUN chmod +x /myanimelist-export

RUN apt-get update \
	&& apt-get install -y --no-install-recommends cron \
	&& apt-get clean \
 	&& rm -rf /var/lib/apt/lists/*

COPY myanimelist-export.yaml /root/.config/myanimelist-export.yaml

COPY myanimelist-export.sh /myanimelist-export.sh

RUN sed -i '1s/^.*#//;s/\r$//' /myanimelist-export.sh

RUN chmod +x /myanimelist-export.sh

RUN crontab -l | { cat; echo "0    3       *       *       *       /myanimelist-export.sh"; } | crontab -

RUN mkdir /export

VOLUME /export

CMD ["cron", "-f"]
