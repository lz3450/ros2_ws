#!/usr/bin/env bash
#
# build.sh
#

docker build --no-cache -t humble:init -f Containerfile .
