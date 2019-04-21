ARG alpine_version=latest
ARG python_version=alpine

FROM alpine:${alpine_version} AS download
RUN apk add --no-cache git
RUN git clone --single-branch --branch master https://github.com/nicolargo/glances.git /glances

FROM python:${python_version}
LABEL maintainer="ryan.horiguchi@gmail.com"
ENV GLANCES_OPT=""
RUN apk add --no-cache --virtual .build_deps \
	gcc \
	musl-dev \
	linux-headers \
	&& pip install bottle docker hddtemp psutil requests setuptools wifi \
	&& apk del .build_deps
COPY --from=download /glances /glances
COPY glances.conf /glances/conf/glances.conf
WORKDIR /glances
EXPOSE 61208 61209
CMD python -m glances --config /glances/conf/glances.conf ${GLANCES_OPT}
