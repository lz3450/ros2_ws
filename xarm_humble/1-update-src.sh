#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ./0-script-lib.sh

UNUSED_PKGS=(
    "xarm_ros2/xarm_gazebo"
    "xarm_ros2/thirdparty/realsense_gazebo_plugin"
)

get_xarm_src

for patch in $(find patches -type f -name "*.patch"); do
  repo=$(basename "$patch" .patch)
  echo "Applying patch: $patch to src/$repo"
  git -C "src/$repo" apply "../../$patch"
done
unset patch repo

for pkg in "${UNUSED_PKGS[@]}"; do
    if [[ -d "src/$pkg" ]]; then
        echo "Removing unused package: $pkg"
        rm -rf "src/$pkg"
    else
        echo "Package $pkg not found, skipping."
    fi
done

echo "Successfully updated xArm source code and applied patches"
