FROM ubuntu:xenial

LABEL Description="MiKTeX test environment, Ubuntu 16.04" Vendor="Christian Schenk" Version="2.9.6619"

RUN    apt-get update \
    && apt-get install -y --no-install-recommends \
           apt-transport-https \
           ca-certificates \
           curl \
           ghostscript \
           make \
           unzip \
           zip

RUN    curl --fail --location --show-error --silent https://cmake.org/files/v3.8/cmake-3.8.2-Linux-x86_64.tar.gz \
     | tar -xz --strip=1 -C /usr/local

RUN    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

RUN mkdir /miktex
WORKDIR /miktex

COPY scripts/*.sh /miktex/
COPY entrypoint.sh /miktex/

ENTRYPOINT ["/miktex/entrypoint.sh"]
CMD ["/miktex/test.sh"]