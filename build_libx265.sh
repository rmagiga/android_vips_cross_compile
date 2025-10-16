#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

URL=https://bitbucket.org/multicoreware/x265_git/downloads/x265_$LIBX265_VERSION.tar.gz
DOWNLOAD_FILE=${DOWNLOADDIR}/x265-$LIBX265_VERSION.tar.gz
EXTRACT_DIR=$SRCDIR/x265-$LIBX265_VERSION

download $URL $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $EXTRACT_DIR

# Androidでのpthreadライブラリリンクエラーを修正するパッチを適用
cd $EXTRACT_DIR
patch -p1 < $SCRIPTDIR/x265_android_pthread.patch

cd source
mkdir build-android && cd build-android
cmake .. -G"Unix Makefiles" \
  -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DENABLE_ASSEMBLY=OFF \
  -DBUILD_SHARED_LIBS=1 \
  -DENABLE_CLI=OFF \
  -DCMAKE_ANDROID_ARCH_ABI=arm64-v8a \
  -DANDROID_ABI=arm64-v8a \
  -DCMAKE_SYSTEM_NAME=Android \
  -DCMAKE_SYSTEM_VERSION=${ANDROID_API} \
  -DCMAKE_ANDROID_NDK=${ANDROID_NDK_HOME} \
  -DANDROID_PLATFORM=android-${ANDROID_API}

make -j$(nproc)
make install
