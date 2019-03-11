FROM python:3.7.2-alpine

LABEL maintainer="ryan.horiguchi@gmail.com"

ARG homeassistant_version
ENV HOMEASSISTANT_VERSION=$homeassistant_version

RUN apk add --no-cache \
  ca-certificates \
  gcc \
  iputils \
  libffi-dev \
  libressl-dev \
  musl-dev \
  nmap \
  openssl-dev \
  py3-bcrypt \
  python3-dev

RUN apk add --no-cache --virtual .build_deps git \
  && git clone -b master https://github.com/home-assistant/home-assistant.git \
  && git -C /home-assistant checkout tags/${HOMEASSISTANT_VERSION}  \
	&& apk del .build_deps

RUN touch /requirements.txt \
  && echo homeassistant==${HOMEASSISTANT_VERSION} >> /requirements.txt \
  && requirements=$(cat /home-assistant/requirements_all.txt) \
  && echo "$requirements" | sed -n "s/\(aiohttp_cors==[\.\d]*\)/\\1/p" >> /requirements.txt \
  && echo "$requirements" | sed -n "s/\(home-assistant-frontend==[\.\d]*\)/\\1/p" >> /requirements.txt \
  && echo "$requirements" | sed -n "s/\(netdisco==[\.\d]*\)/\\1/p" >> /requirements.txt \
  && echo "$requirements" | sed -n "s/\(sqlalchemy==[\.\d]*\)/\\1/p" >> /requirements.txt \
  && echo "$requirements" | sed -n "s/\(xmltodict==[\.\d]*\)/\\1/p" >> /requirements.txt \
  && echo "$requirements" | sed -n "s/\(zeroconf==[\.\d]*\)/\\1/p" >> /requirements.txt \
  && rm -rf /home-assistant

RUN pip install --no-cache-dir -r /requirements.txt \
  && rm -f /requirements.txt

VOLUME /home/homeassistant/.homeassistant

EXPOSE 8123

ENTRYPOINT ["hass", "--open-ui"]
