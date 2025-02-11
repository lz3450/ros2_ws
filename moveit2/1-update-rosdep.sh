#!/usr/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ./0-script-lib.sh

rm -rf src
mkdir -p src

build_env_setup
update_rosdep
