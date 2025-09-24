#!/bin/bash
#
# 2-update-deps.sh
#

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ./0-script-lib.sh

update_xarm_dep_pkgs

echo "Successfully updated xArm dependencies"
