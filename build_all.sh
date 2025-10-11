#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

# libjpeg
$SCRIPTDIR/build_expat.sh
$SCRIPTDIR/build_libjpeg_turbo.sh
# jxl
$SCRIPTDIR/build_libjxl.sh
# openjpeg
$SCRIPTDIR/build_openjpeg.sh
# libspng
$SCRIPTDIR/build_libspng.sh
# libtiff
$SCRIPTDIR/build_libtiff.sh
# libheif
$SCRIPTDIR/build_libaom.sh
$SCRIPTDIR/build_libde265.sh
$SCRIPTDIR/build_libx265.sh
$SCRIPTDIR/build_libheif.sh
#webp
$SCRIPTDIR/build_libwebp.sh

# svg
$SCRIPTDIR/build_cairo.sh
$SCRIPTDIR/build_freetype2.sh
$SCRIPTDIR/build_harfbuzz.sh
$SCRIPTDIR/build_libxml2.sh
$SCRIPTDIR/build_pango.sh
$SCRIPTDIR/build_librsvg.sh

$SCRIPTDIR/build_libvips.sh