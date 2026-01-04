#! /bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

URL="https://download.sourceforge.net/libpng/libpng-$LIBPNG_VERSION.tar.gz"
DOWNLOAD_FILE=${DOWNLOADDIR}/libpng-$LIBPNG_VERSION.tar.gz
EXTRACT_DIR=$SRCDIR/libpng-$LIBPNG_VERSION

download $URL $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $EXTRACT_DIR

cd $EXTRACT_DIR
export CPPFLAGS="$CXXFLAGS"
./configure --host=$TARGET \
  --prefix=$PREFIX \
	--disable-static \
  --enable-shared \
  --with-zlib-prefix=$PREFIX \
  --with-pkgconfigdir=$LIBDIR/pkgconfig

make -j$(nproc)
make install