#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ./0-script-lib.sh

UNUSED_PKGS=(
    "create3_sim/irobot_create_gazebo"
    "create3_sim/irobot_create_ignition"
    "create3_sim/irobot_create_common/irobot_create_common_bringup"
    "create3_sim/irobot_create_common/irobot_create_control"
    "create3_sim/irobot_create_common/irobot_create_nodes"
    "create3_sim/irobot_create_common/irobot_create_toolbox"
)

get_tb4_desktop_src

for pkg in "${UNUSED_PKGS[@]}"; do
    if [[ -d "src/$pkg" ]]; then
        echo "Removing unused package: $pkg"
        rm -rf "src/$pkg"
    else
        echo "Package $pkg not found, skipping."
    fi
done
