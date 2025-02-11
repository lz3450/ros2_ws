#!/usr/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ./0-script-lib.sh

get_moveit2_src

sudo apt-get update
install_moveit2_dep_pkgs
