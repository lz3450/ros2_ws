#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ./0-script-lib.sh

update_ros2_env_setup_pkgs
install_ros2_env_setup_pkgs
