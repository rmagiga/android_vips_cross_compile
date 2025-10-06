#!/bin/bash

SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

DOWNLOAD_FILE=${DOWNLOADDIR}/libjpeg-turbo-$LIBJPEG_TURBO_VERSION.tar.gz

download https://github.com/libjpeg-turbo/libjpeg-turbo/archive/refs/tags/$LIBJPEG_TURBO_VERSION.tar.gz $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $SRCDIR/libjpeg-turbo-$LIBJPEG_TURBO_VERSION

cd $SRCDIR/libjpeg-turbo-$LIBJPEG_TURBO_VERSION
mkdir -p build && cd build

cmake -G"Unix Makefiles" \
  -DANDROID_ABI=arm64-v8a \
  -DANDROID_ARM_MODE=arm \
  -DANDROID_PLATFORM=android-${ANDROID_API} \
  -DANDROID_TOOLCHAIN=${TOOLCHAIN} \
  -DCMAKE_ASM_FLAGS="--target=aarch64-linux-android${ANDROID_API}" \
  -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  $SRCDIR/libjpeg-turbo-$LIBJPEG_TURBO_VERSION

make -j$(nproc)
make install
