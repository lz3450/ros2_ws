#!/bin/bash

. /etc/os-release
. ../ros2_setup.sh
. ../nav2_setup.sh

TB4_DEP_PKGS_FILE="tb4-dep-pkgs-$UBUNTU_CODENAME.txt"
TB4_DEP_PKGS_TO_INSTALL_FILE="tb4-dep-pkgs-to-install-$UBUNTU_CODENAME.txt"

get_tb4_src() {
    if [[ ! -d "src" ]]; then
        mkdir -p src
    fi
    vcs import --force --recursive --input deps.repos src
}

update_tb4_dep_pkgs() {
    rosdep install \
        --rosdistro=$ROS_DISTRO \
        --reinstall \
        --from-paths src \
        --ignore-src \
        -s | awk '{print $5}' | sed -E -e '/^\s*$/d' -e "s/'$//g" | LC_ALL=C sort -n > "$TB4_DEP_PKGS_FILE"

    sed -i \
        -e "s/'$//g" \
        "$TB4_DEP_PKGS_FILE"
}

install_tb4_dep_pkgs() {
    grep -v 'ros-' "$TB4_DEP_PKGS_FILE" | xargs sudo apt-get install --no-install-recommends -s \
        | grep "^Inst" || : | awk '{print $2}' | LC_ALL=C sort -n \
        > "$TB4_DEP_PKGS_TO_INSTALL_FILE"

    if [[ -s "$TB4_DEP_PKGS_FILE" ]]; then
        grep -v 'ros-' "$TB4_DEP_PKGS_FILE" | xargs sudo apt-get install --no-install-recommends -y
    fi
}
