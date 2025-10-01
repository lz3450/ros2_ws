#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ./0-script-lib.sh

get_tb4_src

rm -rf src/create3_sim/irobot_create_gazebo
rm -rf src/create3_sim/irobot_create_ignition

echo "Successfully updated TurtleBot4 (robot) source code and applied patches"
