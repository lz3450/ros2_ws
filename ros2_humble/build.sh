#!/bin/bash

set -e

COMMON_OPTIONS=(
    --symlink-install
    --parallel-workers $(nproc)
    # --continue-on-error
    # --packages-skip-build-finished
)

if [[ -d "/opt/llvm-project-14" ]]; then
    # COMMON_OPTIONS+=(
    #     --cmake-args
    #     "-DCMAKE_VERBOSE_MAKEFILE=ON"
    #     "-DCMAKE_C_COMPILER=/opt/llvm-project/bin/clang"
    #     "-DCMAKE_CXX_COMPILER=/opt/llvm-project/bin/clang++"
    # )
    export PATH="/opt/llvm-project-14/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
fi

export CMAKE_COMMAND="/usr/bin/cmake"
export MAKEFLAGS="-j $(nproc)"

colcon build \
    "${COMMON_OPTIONS[@]}"

# colcon build \
#     --build-base build-merge \
#     --install-base install-merge \
#     --merge-install \
#     "${COMMON_OPTIONS[@]}"

