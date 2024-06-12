#!/bin/bash

set -e

source ../ros2_setup.bash

vcs import --input deps.repos --recursive src

export MAKEFLAGS="-j $(nproc) / 2))"
colcon build \
    --symlink-install \
    --parallel-workers 2 \
    --continue-on-error \
    --packages-skip-build-finished

# COLCON_BUILD_OPTIONS=(
#     --symlink-install
#     --parallel-workers 2
#     --continue-on-error
#     --packages-skip-build-finished
# )

# colcon build \
#     "${COLCON_BUILD_OPTIONS[@]}" \
#     --packages-skip-by-dep depthai \
#     --packages-skip depthai

# colcon build \
#     "${COLCON_BUILD_OPTIONS[@]}" \
#     --packages-select depthai \
#     --cmake-args \
#     -DHUNTER_ENABLED=OFF

# colcon build \
#     "${COLCON_BUILD_OPTIONS[@]}" \
#     --packages-select-by-dep depthai
