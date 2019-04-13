FROM python:3.7.2-alpine AS download

LABEL maintainer="ryan.horiguchi@gmail.com"

RUN apk add --no-cache git

RUN git clone -b master https://github.com/rhoriguchi/tv_time_export.git

FROM python:3.7.2-alpine

LABEL maintainer="ryan.horiguchi@gmail.com"

COPY --from=download /tv_time_export /tv_time_export

RUN pip install --no-cache-dir -r /tv_time_export/requirements.txt

COPY config.yaml /tv_time_export/src/config.yaml

RUN crontab -l | { cat; echo "0    4       *       *       *       python /tv_time_export/src/tv_time_export.py"; } | crontab -

RUN mkdir /tv_time_export/exports

VOLUME /tv_time_export/exports

CMD ["/usr/sbin/crond", "-f"]
