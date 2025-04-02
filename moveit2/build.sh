#!/usr/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ./0-script-lib.sh

if [[ ! -d "src" ]]; then
    get_moveit2_src
fi

# Add the following line to `moveit2/src/moveit2/moveit_planners/stomp/CMakeLists.txt`
# include_directories(SYSTEM ${stomp_INCLUDE_DIRS})

COMMON_OPTIONS=(
    --mixin release
    --parallel-workers $(nproc)
    # --continue-on-error
    --packages-skip-build-finished
    --cmake-args
    -Wno-dev
    "-DCMAKE_BUILD_TYPE=Release"
    "-DOMPL_VERSIONED_INSTALL=OFF"
    # "-DBUILD_TESTING=OFF"
)

MAKEFLAGS="-j $(nproc)" colcon build "${COMMON_OPTIONS[@]}"
