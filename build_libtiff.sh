#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

https://gitlab.com/libtiff/libtiff/-/archive/v4.7.1/libtiff-v4.7.1.tar.gz

DOWNLOAD_FILE=${DOWNLOADDIR}/libtiff-$LIBTIFF_VERSION.tar.gz

download https://gitlab.com/libtiff/libtiff/-/archive/v$LIBTIFF_VERSION/libtiff-v$LIBTIFF_VERSION.tar.gz $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $SRCDIR/libtiff-$LIBTIFF_VERSION

cd $SRCDIR/libtiff-$LIBTIFF_VERSION
./autogen.sh
./configure --host=$TARGET \
	--prefix=$PREFIX \
	--enable-static \
	--enable-shared

make -j$(nproc)
make install
