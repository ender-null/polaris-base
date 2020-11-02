FROM node:alpine

RUN mkdir -p /usr/src/tdlib
WORKDIR /usr/src/tdlib

RUN apk update
RUN apk upgrade
RUN apk add --update ffmpeg opus python make gcc g++ alpine-sdk linux-headers git zlib-dev openssl-dev gperf php php-ctype cmake
RUN git clone https://github.com/tdlib/td.git
WORKDIR /usr/src/tdlib/td

RUN rm -rf build
RUN mkdir -p /usr/src/tdlib/td/build
WORKDIR /usr/src/tdlib/td/build
RUN export CXXFLAGS=""
RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local ..
RUN cmake --build . --target prepare_cross_compiling
WORKDIR /usr/src/tdlib/td
RUN php SplitSource.php
WORKDIR /usr/src/tdlib/td/build
RUN cmake --build . --target install
WORKDIR /usr/src/tdlib/td
RUN php SplitSource.php --undo
WORKDIR /usr/src/tdlib
RUN ls -l /usr/local
