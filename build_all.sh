#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

$SCRIPTDIR/build_expat.sh
$SCRIPTDIR/build_libjpeg_turbo.sh
$SCRIPTDIR/build_libjxl.sh
$SCRIPTDIR/build_libvips.sh