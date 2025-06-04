#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ../ros2_setup.sh

if [[ ! -d "$HOME/.colcon/mixin/default/" ]]; then
    colcon mixin add default https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml
fi
colcon mixin update default

sudo -E colcon --log-base log-opt \
    build \
    --mixin release \
    --build-base build-opt \
    --install-base /opt/ros/moveit2 \
    --merge-install \
    --parallel-workers $(nproc) \
    --cmake-args \
    "-Wno-dev" \
    "-DCMAKE_BUILD_TYPE=Release"
