#!/bin/bash

ubuntu_codename=$(. /etc/os-release && echo $UBUNTU_CODENAME)

set -e

rm -rf src
mkdir -p src
vcs import --force --shallow --recursive --input deps.repos src
if [[ -f "unnecessary_ros2_pkgs.txt" ]]; then
    xargs -a unnecessary_ros2_pkgs.txt -I {} rm -rf src/{}
fi

source ../ros2_setup.sh

rosdep install \
    --reinstall \
    --from-paths src \
    --ignore-src \
    -s | awk '{print $5}' | sed -E '/^\s*$/d' | sort -n > rosdep-$ubuntu_codename.txt

sed -i \
    -e '/^cmake$/d' \
    -e '/^pkg-config$/d' \
    rosdep-$ubuntu_codename.txt
