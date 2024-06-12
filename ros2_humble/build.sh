#!/bin/bash

set -e

mkdir -p src
vcs import --input https://raw.githubusercontent.com/ros2/ros2/humble/ros2.repos src

export PATH="/usr/bin:/opt/llvm-project/bin"
export MAKEFLAGS="-j $(($(nproc) / 2))"
colcon build \
    --symlink-install \
    --parallel-workers 2 \
    --continue-on-error \
    --packages-skip-build-finished
# colcon build --build-base build-merge --install-base install-merge --merge-install --symlink-install --parallel-workers 2 --continue-on-error --packages-skip-build-finished
