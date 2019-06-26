ARG image
ARG version

FROM ${image}:${version}
RUN apk add --no-cache postgresql
COPY wait-for-postgres.sh /
# TODO remove, just save file with correct line ending
RUN sed -i '1s/^.*#//;s/\r$//' /wait-for-postgres.sh \
    && chmod +x /wait-for-postgres.sh
