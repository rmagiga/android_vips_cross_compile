#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

DOWNLOAD_FILE=${DOWNLOADDIR}/libheif-$LIBHEIF_VERSION.tar.gz
download https://github.com/strukturag/libheif/archive/refs/tags/v1.20.2.tar.gz $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $SRCDIR/libheif-$LIBHEIF_VERSION

cd $SRCDIR/libheif-$LIBHEIF_VERSION
mkdir build-android && cd build-android
cmake .. -G"Unix Makefiles" \
  -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_ANDROID_ARCH_ABI=arm64-v8a \
  -DANDROID_ABI=arm64-v8a \
  -DANDROID_PLATFORM=android-${ANDROID_API} \
  -DCMAKE_SYSTEM_NAME=Android \
  -DCMAKE_SYSTEM_VERSION=${ANDROID_API} \
  -DCMAKE_ANDROID_NDK=${ANDROID_NDK_HOME} \
  -DWITH_EXAMPLES=OFF \
  -DBUILD_TESTING=OFF \
  -DTIFF_INCLUDE_DIR=${PREFIX}/include \
  -DTIFF_LIBRARY=${PREFIX}/lib/libtiff.so \
  -DX265_INCLUDE_DIR=${PREFIX}/include \
  -DX265_LIBRARY=${PREFIX}/lib/libx265.so \
  -DLIBDE265_INCLUDE_DIR=${PREFIX}/include \
  -DLIBDE265_LIBRARY=${PREFIX}/lib/libde265.so \
  -DAOM_INCLUDE_DIR=${PREFIX}/include \
  -DAOM_LIBRARY=${PREFIX}/lib/libaom.so

make -j$(nproc)
make install