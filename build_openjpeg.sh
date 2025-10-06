#!/bin/bash

SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

https://github.com/uclouvain/openjpeg/archive/refs/tags/v2.5.4.tar.gz

DOWNLOAD_FILE=${DOWNLOADDIR}/openjpeg-$OPENJPEG_VERSION.tar.gz
download https://github.com/uclouvain/openjpeg/archive/refs/tags/v$OPENJPEG_VERSION.tar.gz $DOWNLOAD_FILE

extract $DOWNLOAD_FILE $SRCDIR/openjpeg-$OPENJPEG_VERSION

cd $SRCDIR/openjpeg-$OPENJPEG_VERSION
mkdir -p build && cd build
cmake -G"Unix Makefiles" \
  -DANDROID_ABI=arm64-v8a \
  -DANDROID_ARM_MODE=arm \
  -DANDROID_PLATFORM=android-${ANDROID_API} \
  -DANDROID_TOOLCHAIN=${TOOLCHAIN} \
  -DCMAKE_ASM_FLAGS="--target=aarch64-linux-android${ANDROID_API}" \
  -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_BUILD_TYPE=Release \
  $SRCDIR/openjpeg-$OPENJPEG_VERSION

cmake --build . -- -j$(nproc)
cmake --install .