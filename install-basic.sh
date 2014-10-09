#!/bin/bash

#
# multi-haskell install script: adds content to the user's ~/.profile in order
# to set an environment variable (MULTIHASKELL_ENVS) identifying the root
# directory where all Haskell installations live. Also, add the proper bin
# directories to the user's PATH, so that he/she has a properly functioning
# Haskell toolchain.
#

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

# Where all haskell environments (GHC + Cabal + (optional) Platform) live
MULTIHASKELL_ENVS_DEFAULT_="${DIR}/envs"  # By default a subdir of the repo itself
MULTIHASKELL_ENVS__=${1:-"$MULTIHASKELL_ENVS_DEFAULT_"}  # But can be given as argument
MULTIHASKELL_ENVS_="$(cd -P "$(readlink -f "${MULTIHASKELL_ENVS__}")" && pwd)"  # absolute

mkdir -p "${MULTIHASKELL_ENVS_}"  # makes sure that the envs tree exists

# Extending PATH to enable the Haskell toolchain as well as the multi-haskell scripts themselves
cat <<EOF >> "${HOME}/.profile"

### MULTI-HASKELL section (http://github.com/joaopizani/multi-haskell) ###

export MULTIHASKELL_ENVS="${MULTIHASKELL_ENVS_}"

PATH="${DIR}/bin:\${PATH}"
PATH="\${MULTIHASKELL_ENVS}/current/ghc/bin:\${PATH}"
PATH="\${MULTIHASKELL_ENVS}/current/platform/bin:\${PATH}"
PATH="\${MULTIHASKELL_ENVS}/current/cabal/bin:\${PATH}"
PATH=".cabal-sandbox/bin:\${PATH}"
export PATH
EOF

