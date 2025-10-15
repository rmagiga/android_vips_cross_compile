#!/bin/bash

SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

URL=https://zlib.net/zlib-$ZLIB_VERSION.tar.gz
DOWNLOAD_FILE=${DOWNLOADDIR}/zlib-$ZLIB_VERSION.tar.gz
EXTRACT_DIR=$SRCDIR/zlib-$ZLIB_VERSION

download $URL $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $EXTRACT_DIR

cd $EXTRACT_DIR
CHOST="$TARGET" ./configure \
	--prefix=$PREFIX

make -j$(nproc)
make install

# 共有ライブラリを生成
OBJ_FILES=$(ls *.o | grep -vE 'example|minigzip')
$CC -shared -fPIC -o libz.so $OBJ_FILES -lc
install -m 644 libz.so $LIBDIR/
