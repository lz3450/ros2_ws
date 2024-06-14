#!/bin/bash

source ../ros2_setup.bash

mkdir -p src
vcs import --input deps.repos src

export MAKEFLAGS="-j $(nproc)"
colcon build \
    --symlink-install \
    --parallel-workers $(nproc)
