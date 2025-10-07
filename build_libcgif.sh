#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

DOWNLOAD_FILE=${DOWNLOADDIR}/cgif-$LIBCGIF_VERSION.tar.gz
download https://github.com/dloebl/cgif/archive/refs/tags/v$LIBCGIF_VERSION.tar.gz $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $SRCDIR/cgif-$LIBCGIF_VERSION

create_cross_file $SCRIPTDIR/cross_file.txt.template $SRCDIR/cgif-$LIBCGIF_VERSION/cross_file.txt

cd $SRCDIR/cgif-$LIBCGIF_VERSION
meson setup build --cross-file cross_file.txt
cd build
ninja
ninja install