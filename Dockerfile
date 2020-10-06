FROM ubuntu:xenial

LABEL Description="MiKTeX test environment, Ubuntu 16.04"
LABEL Vendor="Christian Schenk"
LABEL Version="2.10"

RUN    apt-get update \
    && apt-get install -y --no-install-recommends \
           apt-transport-https \
           ca-certificates \
           curl \
           ghostscript \
           make \
           unzip \
           zip

RUN    curl --fail --location --show-error --silent --output cmake.tar.gz https://cmake.org/files/v3.8/cmake-3.8.2-Linux-x86_64.tar.gz \
     && echo "33e4851d3219b720f4b64fcf617151168f1bffdf5afad25eb4b7f5f58cee3a08 *cmake.tar.gz" | sha256sum --status --check \
     && tar -xzf cmake.tar.gz --strip=1 -C /usr/local

RUN    curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-amd64" \
    && echo "6f3a72f474cafacb3c7b4a7397a1f37d82fcc27b596cbb66e4ea0a8ee92eee76 */usr/local/bin/gosu" | sha256sum --status --check \
    && chmod +x /usr/local/bin/gosu

RUN mkdir /miktex
WORKDIR /miktex

COPY scripts/*.sh /miktex/
COPY entrypoint.sh /miktex/

ENTRYPOINT ["/miktex/entrypoint.sh"]
CMD ["/miktex/test.sh"]
