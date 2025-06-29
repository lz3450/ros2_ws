#!/usr/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ./0-script-lib.sh

update_moveit2_dep_pkgs

echo "Successfully updated MoveIt2 dependencies"
