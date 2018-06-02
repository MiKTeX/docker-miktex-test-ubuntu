#!/bin/sh

set -e

_on_exit() {
    if [ -d ~/.miktex/texmfs/data/miktex/log ]; then
	rm -fr /miktex/test/logfiles
	mkdir /miktex/test/logfiles
	cp ~/.miktex/texmfs/data/miktex/log/* /miktex/test/logfiles
    fi
    exit $3
}

trap '_on_exit $0 $LINENO $?' EXIT

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
