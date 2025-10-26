#!/usr/bin/env bash
#
# run.sh
#

if [[ -z "$1" ]]; then
    echo "Usage: $0 <docker-image>"
    exit 1
fi

docker run -d --rm -u root --name humble -h HUMBLE \
    --mount type=bind,source=/home/kzl/LFS,target=/home/kzl/LFS \
    --mount type=bind,source=/home/kzl/Projects/RoboGuard/rg_ws,target=/home/kzl/Projects/RoboGuard/rg_ws \
    --mount type=bind,source=/home/kzl/Projects/ros2_ws,target=/home/kzl/Projects/ros2_ws "$1"
