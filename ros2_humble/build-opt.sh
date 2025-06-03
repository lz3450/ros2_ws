#!/bin/bash

set -e

export MAKEFLAGS="-j $(nproc)"

colcon build \
    --build-base build-merge \
    --install-base /opt/ros/humble \
    --merge-install \
    --parallel-workers $(nproc) \
    --cmake-args \
    "-Wno-dev" \
    "-DCMAKE_BUILD_TYPE=Release"
