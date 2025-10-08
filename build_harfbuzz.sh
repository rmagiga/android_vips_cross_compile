#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

DOWNLOAD_FILE=${DOWNLOADDIR}/harfbuzz-$HARFBUZZ_VERSION.tar.gz
download https://github.com/harfbuzz/harfbuzz/archive/refs/tags/${HARFBUZZ_VERSION}.tar.gz $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $SRCDIR/harfbuzz-$HARFBUZZ_VERSION

create_cross_file $SCRIPTDIR/cross_file.txt.template $SRCDIR/harfbuzz-$HARFBUZZ_VERSION/cross_file.txt

cd $SRCDIR/harfbuzz-$HARFBUZZ_VERSION
meson setup build --cross-file cross_file.txt
cd build
ninja
ninja install
