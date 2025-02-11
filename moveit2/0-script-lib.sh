#!/usr/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. /etc/os-release
. ../ros2_setup.sh

build_env_setup() {
    if [[ ! -d "moveit2" ]]; then
        git clone https://github.com/moveit/moveit2.git -b $ROS_DISTRO
    fi

    if [[ ! -d "src" ]]; then
        mkdir -p src
        vcs import --force --shallow --recursive --input moveit2/moveit2.repos src
        if [[ -f "unnecessary_ros2_pkgs.txt" ]]; then
            xargs -a unnecessary_ros2_pkgs.txt -I {} rm -rf src/{}
        fi
    fi
}

install_deps() {
    grep -v 'ros-' rosdep-$UBUNTU_CODENAME.txt | xargs sudo apt-get install -s | grep "^Inst" | awk '{print $2}' | LC_ALL=C sort -n > rosdep-installed-pkgs-$UBUNTU_CODENAME.txt
    grep -v 'ros-' rosdep-$UBUNTU_CODENAME.txt | xargs sudo apt-get install -y
}

update_rosdep() {
    rosdep install \
        --rosdistro=$ROS_DISTRO \
        --reinstall \
        --from-paths src \
        --ignore-src \
        -s | awk '{print $5}' | sed -E '/^\s*$/d' | LC_ALL=C sort -n > rosdep-$UBUNTU_CODENAME.txt

    sed -i \
        -e '/^cmake$/d' \
        -e '/^pkg-config$/d' \
        rosdep-$UBUNTU_CODENAME.txt
}
