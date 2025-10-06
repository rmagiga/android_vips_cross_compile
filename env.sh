#!/bin/bash

export DOWNLOADDIR=$HOME/Downloads
export SRCDIR=$HOME/src
export OUTDIR=$HOME/local

# version
export NDK_VERSION=r27d
export ANDROID_API=21

export LIBVIPS_VERSION="8.17.2"
export EXPAT_VERSION="2_7_3"
export LIBJPEG_TURBO_VERSION="3.1.2"
export LIBJXL_VERSION="0.11.1"
export OPENJPEG_VERSION="2.5.4"

# Android NDK
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
export ANDROID_NDK_ROOT="$HOME/Android/Sdk/ndk"
export ANDROID_NDK_HOME="$ANDROID_NDK_ROOT/android-ndk-$NDK_VERSION"

export TOOLCHAIN=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64

export PATH="$TOOLCHAIN/bin":$PATH


# ライブラリ設定
export PREFIX=$OUTDIR
export LIBDIR=$PREFIX/lib
export INCLUDEDIR=$PREFIX/include
export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
export BUILD_SYS=x86_64-linux-gnu
export SYSROOT=$TOOLCHAIN/sysroot/

export TARGET=aarch64-linux-android

export AR=$TOOLCHAIN/bin/llvm-ar
export CC=$TOOLCHAIN/bin/$TARGET$ANDROID_API-clang
export AS=$TOOLCHAIN/bin/llvm-as
export CXX=$TOOLCHAIN/bin/$TARGET$ANDROID_API-clang++
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip

export LD_LIBRARY_PATH=$LIBDIR
export CFLAGS="-fPIC -I$INCLUDEDIR -I$INCLUDEDIR/glib-2.0 -I$LIBDIR/glib-2.0/include"
export CXXFLAGS="-fPIC -I$INCLUDEDIR -I$INCLUDEDIR/glib-2.0 -I$LIBDIR/glib-2.0/include"
export LDFLAGS="-fPIC -pie -L$LD_LIBRARY_PATH"
export LIBS="-L$LD_LIBRARY_PATH"
export INCLUDEARGS="'-fPIC','-I$INCLUDEDIR','-I$INCLUDEDIR/glib-2.0','-I$LIBDIR/glib-2.0/include'"

export PKG_CONFIG=/usr/bin/pkg-config
export PKG_CONFIG_PATH=$LIBDIR/pkgconfig