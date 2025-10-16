#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

URL=https://github.com/harfbuzz/harfbuzz/archive/refs/tags/${HARFBUZZ_VERSION}.tar.gz
DOWNLOAD_FILE=${DOWNLOADDIR}/harfbuzz-$HARFBUZZ_VERSION.tar.gz
EXTRACT_DIR=$SRCDIR/harfbuzz-$HARFBUZZ_VERSION

download $URL $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $EXTRACT_DIR

create_cross_file $SCRIPTDIR/cross_file.txt.template $EXTRACT_DIR/cross_file.txt

cd $EXTRACT_DIR
meson setup build --cross-file cross_file.txt
cd build
ninja
ninja install
