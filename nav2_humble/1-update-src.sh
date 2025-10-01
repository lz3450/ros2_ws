#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ./0-script-lib.sh

get_nav2_src

rm -rf src/navigation2/nav2_system_tests
rm -rf src/bond_core/{bond_core,bondpy,test_bond}
rm -rf src/vision_opencv/{image_geometry,opencv_tests,vision_opencv}
rm -rf src/diagnostics/{diagnostic_aggregator,diagnostic_common_diagnostics,diagnostic_remote_logging,diagnostics,self_test}

echo "Successfully updated Nav2 source code and applied patches"
