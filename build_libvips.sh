#!/bin/bash

SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

DOWNLOAD_FILE=${DOWNLOADDIR}/v$LIBVIPS_VERSION.tar.gz

download https://github.com/libvips/libvips/archive/refs/tags/v$LIBVIPS_VERSION.tar.gz $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $SRCDIR/libvips-$LIBVIPS_VERSION

create_cross_file $SCRIPTDIR/cross_file.txt.template $SRCDIR/libvips-$LIBVIPS_VERSION/cross_file.txt

cd $SRCDIR/libvips-$LIBVIPS_VERSION
meson setup build --cross-file cross_file.txt
cd build
ninja
ninja install