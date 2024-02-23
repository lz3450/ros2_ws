#!/bin/bash

set -e

mkdir -p src
vcs import --input https://raw.githubusercontent.com/ros2/ros2/humble/ros2.repos src

export MAKEFLAGS="-j $(($(nproc) / 2))"
colcon build --symlink-install --parallel-workers 2 --packages-skip-build-finished
