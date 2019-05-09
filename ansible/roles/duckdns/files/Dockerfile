ARG alpine_version=latest

FROM alpine:${alpine_version} AS base
LABEL maintainer="ryan.horiguchi@gmail.com"
ARG duckdns_domain
ARG duckdns_token
RUN apk add --no-cache curl
RUN mkdir /duckdns \
    && echo "echo url=\"https://www.duckdns.org/update?domains=${duckdns_domain}&token=${duckdns_token}&ip=\" | curl -k -o /duckdns/duck.log -K -" >> /duckdns/duck.sh \
    && chmod +x /duckdns/duck.sh
VOLUME /duckdns

FROM base AS cronjob
RUN crontab -l | { cat; echo "*/5    *       *       *       *       /duckdns/duck.sh >/dev/null 2>&1"; } | crontab -
CMD ["/usr/sbin/crond", "-f"]
