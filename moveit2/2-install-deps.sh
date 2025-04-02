#!/usr/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ./0-script-lib.sh

if [[ ! -d "src" ]]; then
    get_moveit2_src
fi
install_moveit2_dep_pkgs
