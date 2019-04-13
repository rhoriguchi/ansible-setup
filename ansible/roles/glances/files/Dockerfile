FROM python:3.7.3-alpine
LABEL maintainer="ryan.horiguchi@gmail.com"
RUN apk add --no-cache --virtual .build_deps \
	gcc \
	musl-dev \
	linux-headers \
	&& pip install bottle docker glances hddtemp psutil requests setuptools wifi \
	&& apk del .build_deps
COPY glances.conf /glances/conf/glances.conf
EXPOSE 61208
CMD python -m glances --config /glances/conf/glances.conf $GLANCES_OPT
