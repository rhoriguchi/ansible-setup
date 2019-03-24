FROM haskell:8.4.4

LABEL maintainer="ryan.horiguchi@gmail.com"

RUN apt-get update \
	&& apt-get install -y --no-install-recommends git \
	&& git clone -b master https://github.com/mat8913/myanimelist-export.git \
	&& apt-get purge -y git \
	&& apt-get clean \
 	&& rm -rf /var/lib/apt/lists/*

RUN cabal update

WORKDIR /myanimelist-export

RUN cabal new-build --only-dependencies --jobs

RUN cabal new-install exe:myanimelist-export

RUN chmod +x /root/.cabal/bin/myanimelist-export

RUN apt-get update \
	&& apt-get install -y --no-install-recommends cron \
	&& apt-get clean \
 	&& rm -rf /var/lib/apt/lists/*

RUN crontab -l | { cat; echo "0    *       *       *       *       /root/.cabal/bin/myanimelist-export"; } | crontab -

COPY myanimelist-export.yaml /root/.config/

RUN mkdir /export

VOLUME /export

CMD ["cron", "-f"]
