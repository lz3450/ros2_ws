#!/usr/bin/bash

set -e

. ../ros2_setup.sh

export MAKEFLAGS="-j $(nproc)"
export CMAKE_PREFIX_PATH="/usr:$CMAKE_PREFIX_PATH"

COMMON_OPTIONS=(
    --symlink-install
    --parallel-workers $(nproc)
    # --continue-on-error
    # --packages-skip-build-finished
    --cmake-args
    -Wno-dev
)

colcon build "${COMMON_OPTIONS[@]}"
