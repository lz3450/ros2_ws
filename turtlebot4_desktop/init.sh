#!/bin/bash

set -e

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -y \
    libignition-math6-dev \
    libgraphicsmagick++1-dev \
    libzmq3-dev \
    libxtensor-dev \
    libceres-dev \
    libignition-plugin-dev \
    libignition-common4-dev \
    libignition-gazebo6-dev \
    libignition-transport11-dev \
    libboost-all-dev \
    libboost-python-dev \
    libgps-dev \
    libgazebo-dev

mkdir -p src
