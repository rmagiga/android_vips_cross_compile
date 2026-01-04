#!/bin/bash

SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

URL="https://github.com/libexpat/libexpat/archive/refs/tags/R_$EXPAT_VERSION.tar.gz"
DOWNLOAD_FILE=${DOWNLOADDIR}/expat-$EXPAT_VERSION.tar.gz
EXTRACT_DIR=$SRCDIR/expat-$EXPAT_VERSION

download $URL $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $EXTRACT_DIR

cd $EXTRACT_DIR/expat
./buildconf.sh
./configure --host=$TARGET \
	--prefix=$PREFIX \
	--disable-static \
	--enable-shared

make -j$(nproc)
make install