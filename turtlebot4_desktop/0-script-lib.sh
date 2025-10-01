#!/bin/bash

. /etc/os-release
. ../nav2_setup.sh

TB4_DESKTOP_DEP_PKGS_FILE="tb4-desktop-dep-pkgs-$UBUNTU_CODENAME.txt"
TB4_DESKTOP_DEP_PKGS_TO_INSTALL_FILE="tb4-desktop-dep-pkgs-to-install-$UBUNTU_CODENAME.txt"

get_tb4_desktop_src() {
    if [[ ! -d "src" ]]; then
        mkdir -p src
    fi
    vcs import --force --recursive --input deps.repos src
}

update_tb4_desktop_dep_pkgs() {
    rosdep install \
        --rosdistro=$ROS_DISTRO \
        --reinstall \
        --from-paths src \
        --ignore-src \
        -s | awk '{print $5}' | sed -E -e '/^\s*$/d' -e "s/'$//g" | LC_ALL=C sort -n > "$TB4_DESKTOP_DEP_PKGS_FILE"

    sed -i \
        -e '/^.*clang.*$/d' \
        -e '/^cmake$/d' \
        -e '/^cppcheck$/d' \
        -e '/^curl$/d' \
        -e '/^doxygen$/d' \
        -e '/^git$/d' \
        -e '/^iwyu$/d' \
        -e '/^jupyter-notebook$/d' \
        -e '/^libboost-/ {/libboost-all-dev/!d}' \
        -e '/^libcurl/d' \
        -e '/^pkg-config$/d' \
        -e "s/'$//g" \
        "$TB4_DESKTOP_DEP_PKGS_FILE"
}

install_tb4_desktop_dep_pkgs() {
    grep -v 'ros-' "$TB4_DESKTOP_DEP_PKGS_FILE" | xargs sudo apt-get install --no-install-recommends -s \
        | (grep "^Inst" || :) | awk '{print $2}' | LC_ALL=C sort -n \
        > "$TB4_DESKTOP_DEP_PKGS_TO_INSTALL_FILE"

    if [[ -s "$TB4_DESKTOP_DEP_PKGS_FILE" ]]; then
        grep -v 'ros-' "$TB4_DESKTOP_DEP_PKGS_FILE" | xargs sudo apt-get install --no-install-recommends -y
    fi
}
