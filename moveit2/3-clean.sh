#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

rm -rf build install log
