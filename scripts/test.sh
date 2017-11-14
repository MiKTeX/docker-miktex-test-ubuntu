#!/bin/sh
set -e
if [ -d /miktex/build ]; then
    apt update
    apt -y install /miktex/build/*.deb
else
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889
    echo "deb http://miktex.org/download/ubuntu xenial universe" | tee /etc/apt/sources.list.d/miktex.list
    apt-get update
    apt-get -y install apt-transport-https
    apt-get -y install miktex
fi
mpm --admin --package-level=basic --upgrade
cd /miktex/test
cmake /miktex/test-suite
set +e
make test
ec=$?
rm -fr logfiles
mkdir logfiles
cp /root/.miktex/texmfs/data/miktex/log/* logfiles
exit $ec
