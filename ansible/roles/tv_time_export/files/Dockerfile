ARG alpine_version=latest
ARG python_version=alpine

FROM python:${alpine_version} AS download
RUN apk add --no-cache git
RUN git clone --single-branch --branch master https://github.com/rhoriguchi/tv_time_export.git /tv_time_export

FROM python:${python_version}
LABEL maintainer="ryan.horiguchi@gmail.com"
COPY --from=download /tv_time_export /tv_time_export
RUN pip install --no-cache-dir -r /tv_time_export/requirements.txt
COPY config.yaml /tv_time_export/src/config.yaml
RUN crontab -l | { cat; echo "0    4       *       *       *       python /tv_time_export/src/tv_time_export.py"; } | crontab -
VOLUME /tv_time_export/exports
CMD ["/usr/sbin/crond", "-f"]
