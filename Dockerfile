FROM ubuntu:jammy

LABEL Description="MiKTeX test environment, Ubuntu 22.04" Vendor="Christian Schenk" Version="22.11.18"

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
