FROM ghcr.io/ender-null/tdlib-docker:latest AS tdlib
FROM node:alpine AS release

LABEL org.opencontainers.image.source https://github.com/ender-null/polaris-base

WORKDIR /usr/local/lib
COPY --from=tdlib /usr/local/lib/libtdjson.so ./

ENV GLIBC_REPO=https://github.com/sgerrand/alpine-pkg-glibc
ENV GLIBC_VERSION=2.30-r0
RUN set -ex && \
    apk --update add libstdc++ curl ca-certificates && \
    for pkg in glibc-${GLIBC_VERSION} glibc-bin-${GLIBC_VERSION}; \
        do curl -sSL ${GLIBC_REPO}/releases/download/${GLIBC_VERSION}/${pkg}.apk -o /tmp/${pkg}.apk; done && \
    apk add --allow-untrusted /tmp/*.apk && \
    rm -v /tmp/*.apk && \
    /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib

RUN apk add --update git tzdata make gcc g++ musl-dev ffmpeg opus python3 python3-dev py3-pip
RUN npm install yarn@latest -g --force
RUN crontab -l -u root | echo "*/15 * * * * find /tmp -type f -delete" | crontab -u root -
ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
