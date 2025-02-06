#!/bin/bash

set -e
set -u
set -o pipefail
# set -x

umask 0022

################################################################################

. /etc/os-release

ROS_DISTRO=jazzy
ROS2_INIT_PKGS_FILE="ros2-$ROS_DISTRO-init-pkgs-$UBUNTU_CODENAME.txt"
ROSDEP_PKGS_FILE="rosdep-$ROS_DISTRO-$UBUNTU_CODENAME.txt"
ROSDEP_PKGS_TO_INSTALL_FILE="rosdep-$ROS_DISTRO-pkgs-to-install-$UBUNTU_CODENAME.txt"

declare -i dry_run=0

default_ros2_build_env_setup() {
    ### ROS2 building environment setup
    # https://docs.ros.org/en/jazzy/Installation/Alternatives/Ubuntu-Development-Setup.html
    sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

    sudo apt-get update
    if [[ ! -f "$ROS2_INIT_PKGS_FILE" ]]; then
        sudo apt-get install -s \
            python3-pip \
            ros-dev-tools \
            | grep "^Inst" || : | awk '{print $2}' | LC_ALL=C sort -n \
            > "$ROS2_INIT_PKGS_FILE"
    fi
    if (( $dry_run == 0 )); then
        sudo apt-get install -y \
            python3-pip \
            ros-dev-tools
    fi
}
customized_ros2_build_env_setup() {
    ### ROS2 building environment setup (customized)
    local -a _pip_pkgs=(
        colcon-argcomplete
        colcon-bash
        colcon-cd
        colcon-cmake
        colcon-common-extensions
        colcon-core
        colcon-defaults
        colcon-devtools
        colcon-installed-package-information
        colcon-library-path
        colcon-metadata
        colcon-mixin
        colcon-notification
        colcon-output
        colcon-override-check
        colcon-package-information
        colcon-package-selection
        colcon-parallel-executor
        colcon-pkg-config
        colcon-powershell
        colcon-python-setup-py
        colcon-recursive-crawl
        colcon-ros
        colcon-test-result
        colcon-zsh
        pytest-mock
        pytest-runner
        pytest-timeout
        rosdep
        vcstool
    )
    python3 -m pip wheel --wheel-dir ~/wheels --no-binary :all: "${_pip_pkgs[@]}"
    python3 -m pip install --user -U --no-index --find-links ~/wheels "${_pip_pkgs[@]}"
}

get_ros2_src() {
    mkdir -p src
    vcs import --force --shallow --recursive --input "https://raw.githubusercontent.com/ros2/ros2/$ROS_DISTRO/ros2.repos" src
}

default_ros2_dep_install() {
    ### ROS2 dependencies installation
    sudo -E rosdep init || :
    rosdep update --rosdistro=$ROS_DISTRO
    rosdep install \
        --rosdistro=$ROS_DISTRO \
        --reinstall \
        --from-paths src \
        --ignore-src \
        --skip-keys="fastcdr rti-connext-dds-6.0.1 urdfdom_headers" \
        -s | awk '{print $5}' | sed -E -e '/^\s*$/d' -e "/'$/s/'//" | LC_ALL=C sort -n > "$ROSDEP_PKGS_FILE"

    sed -i \
        -e '/^clang-format$/d' \
        -e '/^clang-tidy$/d' \
        -e '/^cmake$/d' \
        -e '/^curl$/d' \
        -e '/^file$/d' \
        -e '/^git$/d' \
        -e '/^openssl$/d' \
        -e '/^pkg-config$/d' \
        -e '/^doxygen$/d' \
        -e "s/'$//g" \
        "$ROSDEP_PKGS_FILE"

    if [[ -f "ros2_unnecessary_pkgs.txt" ]]; then
        xargs -a ros2_unnecessary_pkgs.txt -I {} rm -rf src/{}
    fi
    if [[ ! -f "$ROSDEP_PKGS_TO_INSTALL_FILE" ]]; then
        xargs -a "$ROSDEP_PKGS_FILE" sudo apt-get install -s \
            | grep "^Inst" | awk '{print $2}' | LC_ALL=C sort -n \
            > "$ROSDEP_PKGS_TO_INSTALL_FILE"
    fi
    if (( $dry_run == 0 )); then
        xargs -a "$ROSDEP_PKGS_TO_INSTALL_FILE" sudo apt-get install -y
    fi
}
customized_ros2_dep_install() {
    ### ROS2 dependencies installation (customized)
    local -a _deb_pkgs=(
        cmake
        libasio-dev
        libgl1-mesa-dev
        libglx-dev
        liblttng-ctl-dev
        liblttng-ust-dev
        libopencv-dev
        libopengl-dev
        liborocos-kdl-dev
        libtinyxml2-dev
        qtbase5-dev
        libogre-1.12-dev
    )
    sudo apt-get install -s "${_deb_pkgs[@]}" | grep "^Inst" | awk '{print $2}' | LC_ALL=C sort -n > customized-$ROS_DISTRO-pkgs-to-install-$UBUNTU_CODENAME.txt
    sudo apt-get install -y "${_deb_pkgs[@]}"
    local -a _pip_pkgs=(
        pybind11
    )
    python3 -m pip wheel --wheel-dir ~/wheels --no-binary :all: "${_pip_pkgs[@]}"
    python3 -m pip install --user -U --no-index --find-links ~/wheels "${_pip_pkgs[@]}"
}

################################################################################

default_ros2_build_env_setup
get_ros2_src
default_ros2_dep_install
