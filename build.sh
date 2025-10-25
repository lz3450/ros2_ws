#!/usr/bin/env bash
#
# build.sh
#

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

export MAKEFLAGS="-j $(nproc)"

COMMON_OPTIONS=(
    --build-base build
    --install-base install
    --merge-install
    # --symlink-install
    --parallel-workers $(nproc)
    --continue-on-error
    --packages-skip-build-finished
    --cmake-args
    -Wno-dev
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
)

colcon build "${COMMON_OPTIONS[@]}"
