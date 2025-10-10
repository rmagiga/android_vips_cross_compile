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
export LIBSPNG_VERSION="0.7.4"
export LIBTIFF_VERSION="4.7.1"
export LIBAOM_VERSION="3.13.1"
export LIBDE265_VERSION="1.0.16"
export LIBX265_VERSION="4.1"
export LIBHEIF_VERSION="1.20.2"
export LIBWEBP_VERSION="1.6.0"
export LIBCGIF_VERSION="0.5.0"
export CAIRO_VERSION="1.18.4"
export LIBRSVG_VERSION="2.61.1"
export HARFBUZZ_VERSION="12.1.0"
export FREETYPE_VERSION="2.14.1"
export LIBXML2_VERSION="2.15.0"
export PANGO_VERSION="1.57.0"

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

export TARGET="aarch64-linux-android"

export AR=$TOOLCHAIN/bin/llvm-ar
export CC=$TOOLCHAIN/bin/$TARGET$ANDROID_API-clang
export AS=$TOOLCHAIN/bin/llvm-as
export CXX=$TOOLCHAIN/bin/$TARGET$ANDROID_API-clang++
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip



export LD_LIBRARY_PATH=$LIBDIR

# 共通のコンパイルフラグリスト
COMMON_FLAGS=(
    "-fPIC"
    "-I$INCLUDEDIR"
    "-I$INCLUDEDIR/glib-2.0"
    "-I$LIBDIR/glib-2.0/include"
    "-I$INCLUDEDIR/openjpeg-2.5"
    "-I$INCLUDEDIR/libpng16"
    "-I$INCLUDEDIR/freetype2"
    "-I$INCLUDEDIR/cairo"
    "-I$INCLUDEDIR/pango-1.0"
    "-I$INCLUDEDIR/libxml2"
    "-I$INCLUDEDIR/harfbuzz"
    "-I$INCLUDEDIR/librsvg-2.0"
)

# INCLUDEARGSを構築
COMMON_QUOTED=()
for i in "${COMMON_FLAGS[@]}"; do
    COMMON_QUOTED+=("'$i'")
done

export CFLAGS="${COMMON_FLAGS[*]}"
export CXXFLAGS=$CFLAGS
export LDFLAGS="-fPIC -pie -L$LD_LIBRARY_PATH"
export LIBS="-L$LD_LIBRARY_PATH"
export INCLUDEARGS=$(IFS=,; echo "${COMMON_QUOTED[*]}")

export PKG_CONFIG=/usr/bin/pkg-config
export PKG_CONFIG_PATH=$LIBDIR/pkgconfig

# rust
export CARGO_BUILD_TARGET=$TARGET
