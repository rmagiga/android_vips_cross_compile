#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

URL="https://gitlab.com/libtiff/libtiff/-/archive/v$LIBTIFF_VERSION/libtiff-v$LIBTIFF_VERSION.tar.gz"
DOWNLOAD_FILE=${DOWNLOADDIR}/libtiff-$LIBTIFF_VERSION.tar.gz
EXTRACT_DIR=$SRCDIR/libtiff-$LIBTIFF_VERSION

download $URL $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $EXTRACT_DIR

cd $EXTRACT_DIR
./autogen.sh
./configure --host=$TARGET \
	--prefix=$PREFIX \
	--enable-static \
	--enable-shared

make -j$(nproc)
make install
