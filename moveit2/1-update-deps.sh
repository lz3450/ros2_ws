#!/usr/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ./0-script-lib.sh

rm -rf src

init_mixin
get_moveit2_src
update_moveit2_dep_pkgs
