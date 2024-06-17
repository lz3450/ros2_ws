#!/bin/bash

set -e

source ../ros2_setup.sh

COMMON_OPTIONS=(
    --symlink-install
    --parallel-workers $(nproc)
    # --continue-on-error
    # --packages-skip-build-finished
)

export MAKEFLAGS="-j $(nproc)"

colcon build \
    "${COMMON_OPTIONS[@]}"

# colcon build \
#     --build-base build-merge \
#     --install-base install-merge \
#     --merge-install \
#     "${COMMON_OPTIONS[@]}"
