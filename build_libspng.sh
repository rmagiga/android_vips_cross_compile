#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

URL="https://github.com/randy408/libspng/archive/refs/tags/v$LIBSPNG_VERSION.tar.gz"
DOWNLOAD_FILE=${DOWNLOADDIR}/libspng-$LIBSPNG_VERSION.tar.gz
EXTRACT_DIR=$SRCDIR/libspng-$LIBSPNG_VERSION

download $URL $DOWNLOAD_FILE

extract $DOWNLOAD_FILE $EXTRACT_DIR
create_cross_file $SCRIPTDIR/cross_file.txt.template $EXTRACT_DIR/cross_file.txt

cd $EXTRACT_DIR
# todo: DEPRECATION: WrapDB v1 is deprecated, updated using `meson wrap update libpng`
meson setup build --cross-file cross_file.txt
cd build
ninja
ninja install
