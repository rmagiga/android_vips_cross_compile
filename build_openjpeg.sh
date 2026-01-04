#!/bin/bash

SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

URL="https://github.com/uclouvain/openjpeg/archive/refs/tags/v$OPENJPEG_VERSION.tar.gz"
DOWNLOAD_FILE=${DOWNLOADDIR}/openjpeg-$OPENJPEG_VERSION.tar.gz
EXTRACT_DIR=$SRCDIR/openjpeg-$OPENJPEG_VERSION

download $URL $DOWNLOAD_FILE

extract $DOWNLOAD_FILE $EXTRACT_DIR

cd $EXTRACT_DIR
mkdir -p build && cd build
cmake .. -G"Unix Makefiles" \
  -DANDROID_ABI=$ANDROID_ABI \
  -DANDROID_ARM_MODE=arm \
  -DANDROID_PLATFORM=android-${ANDROID_API} \
  -DANDROID_TOOLCHAIN=${TOOLCHAIN} \
  -DCMAKE_ASM_FLAGS="--target=${TARGET}${ANDROID_API}" \
  -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_BUILD_TYPE=Release

cmake --build . -- -j$(nproc)
cmake --install .