#!/bin/bash

source ../ros2_setup.bash

vcs import --input deps.repos src

export MAKEFLAGS="-j $(($(nproc) / 2))"
colcon build \
    --symlink-install \
    --parallel-workers 2 \
    --continue-on-error \
    --packages-skip-build-finished \
    --packages-skip "nav2_system_tests"
