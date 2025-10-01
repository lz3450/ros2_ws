#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ../ros2_setup.sh
. ../nav2_setup.sh

export MAKEFLAGS="-j $(($(nproc) / 2))"

COMMON_OPTIONS=(
    --symlink-install
    --parallel-workers "$(($(nproc) / 2))"
    --continue-on-error
    --packages-skip-build-finished
    --cmake-args
    -Wno-dev
    "-DCMAKE_BUILD_TYPE=Release"
    # "-DBUILD_TESTING=OFF"
)

colcon build \
    "${COMMON_OPTIONS[@]}"
