FROM ubuntu:bionic

LABEL Description="MiKTeX test environment, Ubuntu 18.04" Vendor="Christian Schenk" Version="2.9.6727"

RUN    apt-get update \
    && apt-get install -y --no-install-recommends \
           apt-transport-https \
           ca-certificates \
           cmake \
           curl \
           ghostscript \
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
