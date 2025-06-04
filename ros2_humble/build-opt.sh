#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

export MAKEFLAGS="-j $(nproc)"

colcon build \
    --build-base build-opt \
    --install-base /opt/ros/humble \
    --merge-install \
    --parallel-workers $(nproc) \
    --cmake-args \
    "-Wno-dev" \
    "-DCMAKE_BUILD_TYPE=Release"
