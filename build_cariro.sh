#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

DOWNLOAD_FILE=${DOWNLOADDIR}/cairo-$CAIRO_VERSION.tar.xz
download https://www.cairographics.org/releases/cairo-$CAIRO_VERSION.tar.xz $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $SRCDIR/cairo-$CAIRO_VERSION

create_cross_file $SCRIPTDIR/cross_file.txt.template $SRCDIR/cairo-$CAIRO_VERSION/cross_file.txt

cd $SRCDIR/cairo-$CAIRO_VERSION
meson setup build --cross-file cross_file.txt
cd build
ninja
ninja install
