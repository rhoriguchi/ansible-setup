ARG image
ARG version

FROM ${image}:${version}
RUN apk add --no-cache postgresql
COPY wait-for-postgres.sh /
RUN sed -i '1s/^.*#//;s/\r$//' /wait-for-postgres.sh \
    && chmod +x /wait-for-postgres.sh
