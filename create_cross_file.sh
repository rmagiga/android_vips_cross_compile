#!/bin/bash

SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

sed \
  -e "s|{{ANDROID_API}}|$ANDROID_API|g" \
  -e "s|{{TARGET}}|$TARGET|g" \
  -e "s|{{TOOLCHAIN}}|$TOOLCHAIN|g" \
  -e "s|{{PREFIX}}|$PREFIX|g" \
  -e "s|{{LIBDIR}}|$LIBDIR|g" \
  -e "s|{{INCLUDEDIR}}|$INCLUDEDIR|g" \
  cross_file.txt.template > $SRCDIR/libvips-$LIBVIPS_VERSION/cross_file.txt

