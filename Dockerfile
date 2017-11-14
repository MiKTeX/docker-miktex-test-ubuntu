FROM ubuntu:xenial

LABEL Description="MiKTeX test environment, Ubuntu 16.04" Vendor="Christian Schenk" Version="2.9.6527"

RUN apt-get update
RUN apt-get -y install ghostscript
RUN apt-get -y install make
RUN apt-get -y install unzip

ADD https://cmake.org/files/v3.8/cmake-3.8.2-Linux-x86_64.tar.gz /tmp/cmake-3.8.2-Linux-x86_64.tar.gz
RUN tar -xz --strip=1 -C /usr/local -f /tmp/cmake-3.8.2-Linux-x86_64.tar.gz
RUN rm /tmp/cmake-3.8.2-Linux-x86_64.tar.gz

RUN mkdir /miktex
ADD scripts/*.sh /miktex/

WORKDIR /miktex

CMD ["/miktex/test.sh"]
