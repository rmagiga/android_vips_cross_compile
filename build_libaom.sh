#!/bin/bash

SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

URL=https://storage.googleapis.com/aom-releases/libaom-$LIBAOM_VERSION.tar.gz
DOWNLOAD_FILE=${DOWNLOADDIR}/aom-$LIBAOM_VERSION.tar.gz
EXTRACT_DIR=$SRCDIR/aom-$LIBAOM_VERSION

download $URL $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $EXTRACT_DIR

cd $EXTRACT_DIR
mkdir build-android && cd build-android
cmake .. -G"Unix Makefiles" \
  -DANDROID_ABI=$ANDROID_ABI \
  -DANDROID_PLATFORM=android-${ANDROID_API} \
  -DCMAKE_ASM_FLAGS="--target=${TARGET}${ANDROID_API}" \
  -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DENABLE_TESTS=0 \
  -DBUILD_SHARED_LIBS=1

make -j$(nproc)
make install
