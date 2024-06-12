#!/bin/bash

set -e

sudo apt update
sudo apt upgrade -y

sudo apt install -y \
    libbz2-dev \
    libboost-python-dev \
    libgpiod-dev \
    libbluetooth-dev \
    libspnav-dev \
    libcwiid-dev

mkdir -p src
