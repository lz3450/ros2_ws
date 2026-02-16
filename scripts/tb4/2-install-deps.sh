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

ROS_DISTRO=jazzy
. ../lib.sh

install_dep_pkgs dep-pkgs.txt

echo "Successfully installed dependency packages"
