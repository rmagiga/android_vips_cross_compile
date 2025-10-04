#!/bin/bash

SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

DOWNLOAD_FILE=${DOWNLOADDIR}/v$LIBVIPS_VERSION.tar.gz

sed \
  -e "s|{{ANDROID_API}}|$ANDROID_API|g" \
  -e "s|{{TARGET}}|$TARGET|g" \
  -e "s|{{TOOLCHAIN}}|$TOOLCHAIN|g" \
  -e "s|{{PREFIX}}|$PREFIX|g" \
  -e "s|{{LIBDIR}}|$LIBDIR|g" \
  -e "s|{{INCLUDEDIR}}|$INCLUDEDIR|g" \
  cross_file.txt.template > $SRCDIR/libvips-$LIBVIPS_VERSION/cross_file.txt

download https://github.com/libvips/libvips/archive/refs/tags/v$LIBVIPS_VERSION.tar.gz $DOWNLOAD_FILE

extract $DOWNLOAD_FILE $SRCDIR/libvips-$LIBVIPS_VERSION

cd $SRCDIR/libvips-$LIBVIPS_VERSION
meson setup build --cross-file ../cross_file.txt
cd build
ninja
ninja install