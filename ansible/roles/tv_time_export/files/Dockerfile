ARG alpine_version=latest
ARG python_version=alpine

FROM alpine:${alpine_version} AS download
RUN apk add --no-cache git
RUN git clone --single-branch --branch master https://github.com/rhoriguchi/tv_time_export.git /tv_time_export

FROM python:${python_version} AS base
LABEL maintainer="ryan.horiguchi@gmail.com"
COPY --from=download /tv_time_export/requirements.txt /tv_time_export/requirements.txt
RUN pip install --no-cache-dir -r /tv_time_export/requirements.txt
COPY --from=download /tv_time_export /tv_time_export
VOLUME /tv_time_export/exports
CMD ["python", "/tv_time_export/src/tv_time_export.py"]

FROM base AS cronjob
RUN crontab -l | { cat; echo "0       4       *       *       *       python /tv_time_export/src/tv_time_export.py"; } | crontab -
CMD ["/usr/sbin/crond", "-f"]
