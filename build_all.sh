#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

$SCRIPTDIR/build_expat.sh
$SCRIPTDIR/build_libjpeg_turbo.sh
$SCRIPTDIR/build_libjxl.sh


# svg
$SCRIPTDIR/build_cairo.sh
$SCRIPTDIR/build_freetype2.sh
$SCRIPTDIR/build_harfbuzz.sh
$SCRIPTDIR/build_libxml2.sh
$SCRIPTDIR/build_pango.sh
$SCRIPTDIR/build_librsvg.sh

$SCRIPTDIR/build_libvips.sh