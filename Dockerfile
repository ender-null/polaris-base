FROM ghcr.io/ender-null/tdlib-docker:latest AS tdlib
FROM node:alpine AS release

LABEL org.opencontainers.image.source https://github.com/ender-null/polaris-base

WORKDIR /usr/local/lib
COPY --from=tdlib /usr/local/lib/libtdjson.so ./

ENV GLIBC_REPO=https://github.com/sgerrand/alpine-pkg-glibc
ENV GLIBC_VERSION=2.35-r1
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub\
    wget ${GLIBC_REPO}/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk\
    apk add glibc-${GLIBC_VERSION}.apk

RUN apk add --update git tzdata make gcc g++ musl-dev ffmpeg opus python3 python3-dev py3-pip
RUN npm install yarn@latest -g --force
RUN crontab -l -u root | echo "*/15 * * * * find /tmp -type f -delete" | crontab -u root -
ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
