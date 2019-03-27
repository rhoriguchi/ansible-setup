FROM python:3.7.2-alpine

LABEL maintainer="ryan.horiguchi@gmail.com"

RUN apk add --no-cache --virtual .build_deps git \
	&& git clone -b master https://github.com/rhoriguchi/tv_time_export.git \
	&& apk del .build_deps

RUN pip install --no-cache-dir -r /tv_time_export/requirements.txt

COPY config.yaml /tv_time_export/src/config.yaml

VOLUME /tv_time_export/exports

CMD ["python", "/tv_time_export/src/tv_time_export.py"]
