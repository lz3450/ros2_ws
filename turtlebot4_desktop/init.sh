#!/bin/bash

set -e

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -y \
    libignition-math6-dev

mkdir -p src
