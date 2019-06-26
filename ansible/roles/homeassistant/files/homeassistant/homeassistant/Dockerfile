ARG image
ARG version

FROM ${image}:${version}
RUN apk add --no-cache postgresql
COPY wait-for-postgres.sh /
RUN chmod +x /wait-for-postgres.sh
