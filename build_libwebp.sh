#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.6.0.tar.gz

DOWNLOAD_FILE=${DOWNLOADDIR}/libwebp-$LIBWEBP_VERSION.tar.gz
download https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-$LIBWEBP_VERSION.tar.gz $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $SRCDIR/libwebp-$LIBWEBP_VERSION

cd $SRCDIR/libwebp-$LIBWEBP_VERSION

./autogen.sh
./configure --host=$TARGET \
	--prefix=$PREFIX \
	--enable-static \
	--enable-shared

make -j$(nproc)
make install
