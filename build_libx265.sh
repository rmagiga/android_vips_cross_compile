#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

https://bitbucket.org/multicoreware/x265_git/downloads/x265_4.1.tar.gz
DOWNLOAD_FILE=${DOWNLOADDIR}/x265-$LIBX265_VERSION.tar.gz
download https://bitbucket.org/multicoreware/x265_git/downloads/x265_$LIBX265_VERSION.tar.gz $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $SRCDIR/x265-$LIBX265_VERSION

# Androidでのpthreadライブラリリンクエラーを修正するパッチを適用
cd $SRCDIR/x265-$LIBX265_VERSION
patch -p1 < $SCRIPTDIR/x265_android_pthread.patch

cd source
mkdir build-android && cd build-android
cmake .. -G"Unix Makefiles" \
  -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DENABLE_ASSEMBLY=OFF \
  -DBUILD_SHARED_LIBS=1 \
  -DENABLE_CLI=OFF \
  -DANDROID_PLATFORM=android-${ANDROID_API}

make -j$(nproc)
make install
