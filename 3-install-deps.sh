#!/usr/bin/env bash
#
# install-deps.sh
#

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

ROS_DISTRO=humble
. scripts/lib.sh

install_dep_pkgs

echo "Successfully installed dependency packages"
