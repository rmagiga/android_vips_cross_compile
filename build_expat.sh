#!/bin/bash

SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

DOWNLOAD_FILE=${DOWNLOADDIR}/expat-$EXPAT_VERSION.tar.gz
download https://github.com/libexpat/libexpat/archive/refs/tags/R_$EXPAT_VERSION.tar.gz $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $SRCDIR/expat-$EXPAT_VERSION

cd $SRCDIR/expat-$EXPAT_VERSION/expat
./buildconf.sh
./configure --host=$TARGET \
	--prefix=$PREFIX \
	--enable-static \
	--enable-shared

make -j$(nproc)
make install