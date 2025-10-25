#!/usr/bin/env bash
#
# lib.sh
#

if [[ -z "$ROS_DISTRO" ]]; then
    echo "ROS_DISTRO is not set"
    exit 1
fi

. /etc/os-release

PKGLISTS_DIR="scripts/pkglists"
ROS2_DEV_TOOLS_DEP_PKGS_FILE="$PKGLISTS_DIR/ros2-dev-tools-dep-pkgs-$UBUNTU_CODENAME.txt"
ROS2_DEP_PKGS_FILE="$PKGLISTS_DIR/ros2-dep-pkgs-$UBUNTU_CODENAME.txt"
ROS2_DEP_PKGS_TO_INSTALL_FILE="$PKGLISTS_DIR/ros2-dep-pkgs-to-install-$UBUNTU_CODENAME.txt"

setup_ros2_repo() {
    ### ROS2 building environment setup
    # https://docs.ros.org/en/$ROS_DISTRO/Installation/Alternatives/Ubuntu-Development-Setup.html
    sudo apt update && sudo apt install curl -y
    export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
    curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $VERSION_CODENAME)_all.deb"
    sudo apt install /tmp/ros2-apt-source.deb
}

update_ros2_dev_tools_dep_pkgs() {
    if [[ ! -d "$PKGLISTS_DIR" ]]; then
        mkdir -p "$PKGLISTS_DIR"
    fi

    sudo apt-get update
    sudo apt-get install --no-install-recommends -s \
        python3-flake8-docstrings \
        python3-pip \
        python3-pytest-cov \
        ros-dev-tools \
        | (grep "^Inst" || :) | awk '{print $2}' | LC_ALL=C sort -n \
        > "$ROS2_DEV_TOOLS_DEP_PKGS_FILE"
}

install_ros2_dev_tools_dep_pkgs() {
    sudo apt-get install --no-install-recommends \
        python3-flake8-docstrings \
        python3-pip \
        python3-pytest-cov \
        ros-dev-tools
}

get_src() {
    if [[ -z "$1" ]]; then
        echo "No repos file specified"
        return 1
    fi
    local -r _repos="$1"

    if [[ ! -d "src" ]]; then
        mkdir -p src
    fi
    vcs import --force --shallow --recursive --input "$_repos" src
}

update_dep_pkgs() {
    if [[ ! -f "/etc/ros/rosdep/sources.list.d/20-default.list" ]]; then
        sudo -E rosdep init
    fi
    rosdep update --rosdistro=$ROS_DISTRO
    rosdep install \
        --rosdistro=$ROS_DISTRO \
        --reinstall \
        --from-paths src \
        --ignore-src \
        --skip-keys="fastcdr rti-connext-dds-6.0.1 urdfdom_headers" \
        -s | awk '{print $5}' | sed -E -e '/^\s*$/d' -e "/'$/s/'//" | LC_ALL=C sort -n > "$ROS2_DEP_PKGS_FILE"

    sed -i \
        -e '/^.*clang.*$/d' \
        -e '/^cmake$/d' \
        -e '/^cppcheck$/d' \
        -e '/^curl$/d' \
        -e '/^doxygen$/d' \
        -e '/^file$/d' \
        -e '/^git$/d' \
        -e '/^libboost-/ {/libboost-all-dev/!d}' \
        -e '/^libcurl/d' \
        -e '/^openssl$/d' \
        -e '/^pkg-config$/d' \
        -e "s/'$//g" \
        "$ROS2_DEP_PKGS_FILE"
}

install_dep_pkgs() {
    xargs -a "$ROS2_DEP_PKGS_FILE" sudo apt-get install --no-install-recommends -s \
        | (grep "^Inst" || :) | awk '{print $2}' | LC_ALL=C sort -n \
        > "$ROS2_DEP_PKGS_TO_INSTALL_FILE"

    if [[ -s "$ROS2_DEP_PKGS_FILE" ]]; then
        xargs -a "$ROS2_DEP_PKGS_FILE" sudo apt-get install --no-install-recommends
    fi
}

################################################################################

install_ros2_dev_tools_custom() {
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

install_ros2_dep_pkgs_custom() {
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
    sudo apt-get install --no-install-recommends -s "${_deb_pkgs[@]}" | grep "^Inst" | awk '{print $2}' | LC_ALL=C sort -n > customized-$ROS_DISTRO-pkgs-to-install-$UBUNTU_CODENAME.txt
    sudo apt-get install --no-install-recommends -y "${_deb_pkgs[@]}"
    local -a _pip_pkgs=(
        pybind11
    )
    python3 -m pip wheel --wheel-dir ~/wheels --no-binary :all: "${_pip_pkgs[@]}"
    python3 -m pip install --user -U --no-index --find-links ~/wheels "${_pip_pkgs[@]}"
}
