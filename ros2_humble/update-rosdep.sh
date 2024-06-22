#!/bin/bash

set -e

rm -rf src
mkdir -p src
vcs import --force --shallow --recursive --input https://raw.githubusercontent.com/ros2/ros2/humble/ros2.repos src
if [[ -f "unnecessary_ros2_pkgs.txt" ]]; then
    xargs -a unnecessary_ros2_pkgs.txt -I {} rm -rf src/{}
fi

rosdep install \
    --reinstall \
    --from-paths src \
    --ignore-src \
    --skip-keys "fastcdr rti-connext-dds-6.0.1 urdfdom_headers ignition-math6 ignition-cmake2" \
    -s | awk '{print $5}' | sed -E '/^\s*$/d' | sort -n > rosdep.txt

sed -i \
    -e '/^clang-format$/d' \
    -e '/^clang-tidy$/d' \
    -e '/^cmake$/d' \
    -e '/^curl$/d' \
    -e '/^file$/d' \
    -e '/^git$/d' \
    -e '/^openssl$/d' \
    -e '/^pkg-config$/d' \
    rosdep.txt
