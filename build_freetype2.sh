#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

DOWNLOAD_FILE=${DOWNLOADDIR}/freetype-$FREETYPE_VERSION.tar.gz
download https://download.savannah.gnu.org/releases/freetype/freetype-$FREETYPE_VERSION.tar.gz $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $SRCDIR/freetype-$FREETYPE_VERSION

create_cross_file $SCRIPTDIR/cross_file.txt.template $SRCDIR/freetype-$FREETYPE_VERSION/cross_file.txt

cd $SRCDIR/freetype-$FREETYPE_VERSION
meson setup build --cross-file cross_file.txt
cd build
ninja
ninja install
