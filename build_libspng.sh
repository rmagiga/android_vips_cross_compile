#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

DOWNLOAD_FILE=${DOWNLOADDIR}/libspng-$LIBSPNG_VERSION.tar.gz
download https://github.com/randy408/libspng/archive/refs/tags/v$LIBSPNG_VERSION.tar.gz $DOWNLOAD_FILE

extract $DOWNLOAD_FILE $SRCDIR/libspng-$LIBSPNG_VERSION
create_cross_file $SCRIPTDIR/cross_file.txt.template $SRCDIR/libspng-$LIBSPNG_VERSION/cross_file.txt

cd $SRCDIR/libspng-$LIBSPNG_VERSION
meson setup build --cross-file cross_file.txt
cd build
ninja
ninja install
