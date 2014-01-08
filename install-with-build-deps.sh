#!/bin/bash

# The trick to find out the full REAL path to the dir where THIS script lives
DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"


"${DIR}/install-basic.sh"

sudo apt-get install $(cat apt-required-packages)
cabal install $(cat cabal-required-packages)

