# Ubuntu 16.04 docker image with MiKTeX test environment

## Obtaining the image

Get the latest image from the registry:

    docker pull miktex/miktex-test-xenial

or build it yourself:

    docker build --tag miktex/miktex-test-xenial .

## Using the image

### Prerequisites

The directory containing the MiKTeX test suite must be mounted to the
container path `/miktex/test-suite`.  You can obtain the test suite
from [GitHub](https://github.com/MiKTeX/miktex-testing).

The test directory must be mounted to the container path
`/miktex/test`.

Optional: The directory containing the .deb package file must be
mounted to `/miktex/build`.  If this directory is not mounted then the
package will be installed from the official source.

### Example

Run the tests:

    git clone https://github.com/MiKTeX/miktex-testing ~/work/miktex/test-suite
    docker run -t \
      -v ~/work/miktex/test-suite:/miktex/test-suite:ro \
      -v ~/work/miktex/tests/xenial:/miktex/test:rw \
      miktex/miktex-test-xenial
