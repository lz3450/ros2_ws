#!/bin/bash

set -e

export MAKEFLAGS="-j $(nproc)"

COMMON_OPTIONS=(
    --symlink-install
    --parallel-workers $(nproc)
    # --continue-on-error
    # --packages-skip-build-finished
    --cmake-args
    -Wno-dev
    "-DCMAKE_BUILD_TYPE=Release"
)

colcon build "${COMMON_OPTIONS[@]}"

# colcon build \
#     --build-base build-merge \
#     --install-base install-merge \
#     --merge-install \
#     "${COMMON_OPTIONS[@]}"
