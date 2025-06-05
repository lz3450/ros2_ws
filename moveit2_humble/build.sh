#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ../ros2_setup.sh

export MAKEFLAGS="-j $(nproc)"

COMMON_OPTIONS=(
    --mixin release
    --parallel-workers $(nproc)
    # --continue-on-error
    # --packages-skip-build-finished
    --cmake-args
    -Wno-dev
    "-DCMAKE_BUILD_TYPE=Release"
    # "-DBUILD_TESTING=OFF"
)

colcon build "${COMMON_OPTIONS[@]}"
