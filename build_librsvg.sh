#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

DOWNLOAD_FILE=${DOWNLOADDIR}/librsvg-$LIBRSVG_VERSION.tar.gz
download https://gitlab.gnome.org/GNOME/librsvg/-/archive/$LIBRSVG_VERSION/librsvg-$LIBRSVG_VERSION.tar.gz $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $SRCDIR/librsvg-$LIBRSVG_VERSION

create_cross_file $SCRIPTDIR/cross_file.txt.template $SRCDIR/librsvg-$LIBRSVG_VERSION/cross_file.txt

sed -i "s/^subdir('rsvg_convert')/# &/" $SRCDIR/librsvg-$LIBRSVG_VERSION/meson.build

cd $SRCDIR/librsvg-$LIBRSVG_VERSION
meson setup build --cross-file cross_file.txt \
  -Dtests=false \
  -Dvala=disabled \
  -Dintrospection=disabled \
  -Dpixbuf=disabled \
  -Dpixbuf-loader=disabled \
  -Davif=disabled \
  -Ddocs=disabled \
  -Drsvg-convert=disabled \
  -Dtriplet=$TARGET
cd build
ninja
ninja install
