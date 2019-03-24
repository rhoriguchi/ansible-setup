FROM python:3.7.2-alpine

LABEL maintainer="ryan.horiguchi@gmail.com"

RUN apk add --no-cache --virtual .build_deps \
	gcc \
	musl-dev \
	linux-headers \
	&& pip install bottle docker hddtemp psutil requests setuptools wifi \
	&& apk del .build_deps

RUN apk add --no-cache --virtual .build_deps git \
	&& git clone -b develop https://github.com/nicolargo/glances.git \
	&& apk del .build_deps

EXPOSE 61208

COPY glances.conf /glances/conf/

CMD python -m glances --config /glances/conf/glances.conf $GLANCES_OPT
