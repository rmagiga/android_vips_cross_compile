#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

DOWNLOAD_FILE=${DOWNLOADDIR}/android-ndk-$NDK_VERSION-linux.zip

# ダウンロード
download https://dl.google.com/android/repository/android-ndk-$NDK_VERSION-linux.zip $DOWNLOAD_FILE

# 展開
extract $DOWNLOAD_FILE $ANDROID_NDK_ROOT