#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

DOWNLOAD_FILE=${DOWNLOADDIR}/libxml2-$LIBXML2_VERSION.tar.gz
download https://gitlab.gnome.org/GNOME/libxml2/-/archive/v${LIBXML2_VERSION}/libxml2-${LIBXML2_VERSION}.tar.gz $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $SRCDIR/libxml2-$LIBXML2_VERSION

create_cross_file $SCRIPTDIR/cross_file.txt.template $SRCDIR/libxml2-$LIBXML2_VERSION/cross_file.txt

cd $SRCDIR/libxml2-$LIBXML2_VERSION
meson setup build --cross-file cross_file.txt
cd build
ninja
ninja install
