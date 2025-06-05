#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. /opt/ros/humble/local_setup.bash

sudo -E colcon --log-base log-opt \
    build \
    --mixin release \
    --build-base build-opt \
    --install-base /opt/moveit2/humble \
    --merge-install \
    --parallel-workers $(nproc) \
    --cmake-args \
    "-Wno-dev" \
    "-DCMAKE_BUILD_TYPE=Release"
