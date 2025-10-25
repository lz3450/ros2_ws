#!/usr/bin/env bash
#
# update-deps.sh
#

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

ROS_DISTRO=humble
. scripts/lib.sh

update_dep_pkgs

echo "Successfully updated dependency package list"
