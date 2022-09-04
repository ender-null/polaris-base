# polaris-base

<a href="https://github.com/ender-null/polaris-base/actions?query=workflow%3ADocker%20(alpine)">
    <img alt="Build Status Alpine" src="https://github.com/ender-null/polaris-base/workflows/Docker/badge.svg"></a>

<a href="https://github.com/ender-null/polaris-base/actions?query=workflow%3ADocker%20(debian)">
    <img alt="Build Status Debian" src="https://github.com/ender-null/polaris-base/workflows/Docker/badge.svg"></a>

Base image for **[polaris](https://github.com/ender-null/polaris)** and **[polaris.py](https://github.com/ender-null/polaris.py)**. Comes in two versions `alpine` based on `node:alpine` and `debian` based on `node:slim`. They come with the following changes:

- TDLib precompiled in `/usr/local/lib/libtdjson.so`
- Git
- Python3 Python3-dev Python3-pip
- Latest NPM version
- FFmpeg and Opus
- Compiler tools: `make` and (Debian) `cmake` `clang` / (Alpine) `gcc` `g++`
- Cron job to clean `/tmp` every 15 minutes
- Set timezone to Europe/Madrid