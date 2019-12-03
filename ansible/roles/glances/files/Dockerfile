ARG python_version=alpine

FROM python:${python_version}
LABEL maintainer="ryan.horiguchi@gmail.com"
ENV GLANCES_OPT=""
RUN apk add --no-cache --virtual .build_deps \
	gcc \
	musl-dev \
	linux-headers \
	&& pip install \
    bottle \
    docker \
    hddtemp \
    psutil \
    requests \
    setuptools \
    wifi \
	&& apk del .build_deps
COPY ./glances /glances
RUN touch /glances/conf/glances.conf
WORKDIR /glances
EXPOSE 61208
CMD python -m glances --config /glances/conf/glances.conf ${GLANCES_OPT}
