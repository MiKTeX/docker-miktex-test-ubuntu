#!/bin/sh

set -e

_on_exit() {
    if [ -d ~/.miktex/texmfs/data/miktex/log ]; then
	echo going to save log files:
	ls -l ~/.miktex/texmfs/data/miktex/lo
	rm -fr /miktex/test/logfiles
	mkdir /miktex/test/logfiles
	cp ~/.miktex/texmfs/data/miktex/log/* /miktex/test/logfiles
    fi
    echo test.sh exits with $1
    exit $1
}

trap '_on_exit $?' EXIT

miktexsetup finish
if [ -d /miktex/repository ]; then
    mpm --set-repository=/miktex/repository
else
    # TODO: --check-repositories
    mpm --list-repositories
fi
initexmf --set-config-value=[MPM]AutoInstall=1
mpm --package-level=basic --upgrade
cd /miktex/test
export PATH=~/bin:$PATH
cmake /miktex/test-suite
make test
