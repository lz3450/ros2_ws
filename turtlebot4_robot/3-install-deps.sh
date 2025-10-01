#!/usr/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ./0-script-lib.sh

install_tb4_dep_pkgs

echo "Successfully installed TurtleBot4 dependencies"
