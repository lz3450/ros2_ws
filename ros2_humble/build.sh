#!/bin/bash

set -e

COMMON_OPTIONS=(
    --symlink-install
    --parallel-workers $(nproc)
    # --continue-on-error
    # --packages-skip-build-finished
)

export CMAKE_COMMAND="/usr/bin/cmake"
export MAKEFLAGS="-j $(nproc)"

colcon build \
    "${COMMON_OPTIONS[@]}"

# colcon build \
#     --build-base build-merge \
#     --install-base install-merge \
#     --merge-install \
#     "${COMMON_OPTIONS[@]}"

