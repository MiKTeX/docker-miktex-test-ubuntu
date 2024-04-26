FROM ubuntu:noble

LABEL Description="MiKTeX test environment, Ubuntu 24.04" Vendor="Christian Schenk" Version="24.4.26"

ENV DEBIAN_FRONTEND=noninteractive

RUN \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        cmake \
        curl \
        ghostscript \
        gnupg \
        gosu \
        make \
        unzip \
        zip

RUN mkdir /miktex
WORKDIR /miktex

COPY scripts/*.sh /miktex/
COPY entrypoint.sh /miktex/

ENTRYPOINT ["/miktex/entrypoint.sh"]
CMD ["/miktex/test.sh"]
