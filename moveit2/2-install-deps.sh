#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ./0-script-lib.sh

build_env_setup
install_deps
