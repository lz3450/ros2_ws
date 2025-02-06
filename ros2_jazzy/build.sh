#!/bin/bash

set -e

export MAKEFLAGS="-j $(nproc)"
export CMAKE_PREFIX_PATH="/usr:$CMAKE_PREFIX_PATH"

COMMON_OPTIONS=(
    --symlink-install
    --parallel-workers $(nproc)
    # --continue-on-error
    # --packages-skip-build-finished
)

colcon build "${COMMON_OPTIONS[@]}"

# colcon build \
#     --build-base build-merge \
#     --install-base install-merge \
#     --merge-install \
#     "${COMMON_OPTIONS[@]}"
