#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

DOWNLOAD_FILE=${DOWNLOADDIR}/pango-$PANGO_VERSION.tar.gz
download https://gitlab.gnome.org/GNOME/pango/-/archive/$PANGO_VERSION/pango-$PANGO_VERSION.tar.gz $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $SRCDIR/pango-$PANGO_VERSION

create_cross_file $SCRIPTDIR/cross_file.txt.template $SRCDIR/pango-$PANGO_VERSION/cross_file.txt

cd $SRCDIR/pango-$PANGO_VERSION
meson setup build --cross-file cross_file.txt
cd build
ninja
ninja install
