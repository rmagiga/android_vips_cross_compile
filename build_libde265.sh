#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

URL=https://github.com/strukturag/libde265/archive/refs/tags/v$LIBDE265_VERSION.tar.gz
DOWNLOAD_FILE=${DOWNLOADDIR}/libde265-$LIBDE265_VERSION.tar.gz
EXTRACT_DIR=$SRCDIR/libde265-$LIBDE265_VERSION

download $URL $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $EXTRACT_DIR

cd $EXTRACT_DIR
mkdir build-android && cd build-android
cmake .. -G"Unix Makefiles" \
  -DANDROID_ABI=arm64-v8a \
  -DANDROID_PLATFORM=android-${ANDROID_API} \
  -DCMAKE_ASM_FLAGS="--target=${TARGET}${ANDROID_API}" \
  -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DENABLE_TESTS=0 \
  -DBUILD_SHARED_LIBS=1

make -j$(nproc)
make install
