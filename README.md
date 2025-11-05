# Android用のlibvipsをクロスコンパイルするプロジェクト

aarch64を対象にしたlivipsのライブラリを作成するプロジェクトです。

事前にglibのクロスコンパイルしたライブラリが必要です。[android_glib_cross_compile](https://github.com/rmagiga/android_glib_cross_compile)で作成が可能です。

2025/10/16時点で最新のバージョンを使用しています。
一般的な画像を使用することを想定しているため、一部対象外のフォーマットが存在しています。
```
vips 8.17.2

  Dependencies
    glib-2.0                          : 2.84.2
    gio-2.0                           : 2.84.2
    gobject-2.0                       : 2.84.2
    gmodule-no-export-2.0             : 2.84.2
    expat                             : 2.7.3
    zlib                              : 1.3.1
    quantizr                          : 1.4.3
    cgif                              : 0.5.0
    libjpeg                           : 3.1.2
    spng                              : 0.7.4
    libwebp                           : 1.6.0
    libwebpmux                        : 1.6.0
    libwebpdemux                      : 1.6.0
    pangocairo                        : 1.57.0
    pangoft2                          : 1.57.0
    fontconfig                        : 2.17.0
    libtiff-4                         : 4.7.1
    librsvg-2.0                       : 2.61.1
    cairo                             : 1.18.4
    libopenjp2                        : 2.5.4
    libhwy                            : 1.2.0
    libheif                           : 1.20.2
    libjxl                            : 0.11.1
    libjxl_threads                    : 0.11.1

  Build options
    enable debug                      : NO
    enable deprecated                 : YES
    enable modules                    : YES
    enable docs                       : NO
    enable C++ docs                   : NO
    enable introspection              : NO
    enable examples                   : YES
    enable C++ binding                : YES
    enable RAD load/save              : YES
    enable Analyze7 load              : YES
    enable PPM load/save              : YES
    enable GIF load                   : YES

  Optional external packages
    FFTs with fftw                    : NO
    SIMD support with libhwy          : YES
    ICC profile support with lcms2    : NO
    deflate compression with zlib     : YES
    text rendering with pangocairo    : YES
    font file support with fontconfig : YES
    EXIF metadata support with libexif: NO

  External image format libraries
    JPEG load/save with libjpeg       : YES
    JXL load/save with libjxl         : YES (dynamic module: YES)
    JPEG2000 load/save with libopenjp2: YES
    PNG load/save with spng           : YES
    image quantisation with quantizr  : YES
    TIFF load/save with libtiff-4     : YES
    image pyramid save with libarchive: NO
    HEIC/AVIF load/save with libheif  : YES (dynamic module: YES)
    WebP load/save with libwebp       : YES
    PDF load with PDFium or Poppler   : NO (dynamic module: NO)
    SVG load with librsvg-2.0         : YES
    EXR load with OpenEXR             : NO
    WSI load with OpenSlide           : NO (dynamic module: NO)
    Matlab load with Matio            : NO
    NIfTI load/save with libnifti     : NO
    FITS load/save with cfitsio       : NO
    GIF save with cgif                : YES
    Magick load/save with MagickCore  : NO (dynamic module: NO)
```

## 環境

- Windows 11 25H2
- WSL2
- Ubuntu 22.04 or 24.04

## WSL上にUbuntuをインストール

すでにWSL2を使用できるものとします。

Ubuntu 22.04をインストールします。コマンドラインを開いて、以下のコマンドを入力してください。
```
wsl --install -d Ubuntu-22.04
```
起動したら、ユーザーとパスワードを設定してください。

Ubuntu22.04を初期化したい場合は、以下を入力してください。
```
wsl --unregister Ubuntu-22.04
```

## Ubuntu パッケージ設定

ビルドに必要なパッケージのインストール
```
git clone https://github.com/rmagiga/android_vips_cross_compile.git
cd android_vips_cross_compile
```

ビルド環境を構築します。
OSのパッケージのインストール、Pythonの仮想環境の構築、rustのインストール、Android NDKのダウンロード・配置を行います。
スクリプト内部で、sudoを実行しているので、sudoに対する権限が必要です。

```
./install.sh
./setup_ndk.sh
```


## libvipsのビルド・インストール

```
. "$HOME/.cargo/env"
./build_all.sh
```

## 変数と変数の説明

env.shにあるスクリプトで使用するバージョンやパスの設定です。

| 変数 | 説明 | デフォルト値 |
|---|---|---|
| DOWNLOADDIR | ダウンロードディレクトリ | $HOME/Downloads |
| SRCDIR | ソースコードディレクトリ | $HOME/src |
| OUTDIR | 出力ディレクトリ | $HOME/local |
| NDK_VERSION | Android NDKのバージョン | r27d |
| ANDROID_API | Android APIレベル | 21 |
| LIBVIPS_VERSION | libvipsのバージョン | 8.17.2 |
| EXPAT_VERSION | expatのバージョン | 2_7_3 |
| LIBJPEG_TURBO_VERSION | libjpeg-turboのバージョン | 3.1.2 |
| LIBJXL_VERSION | libjxlのバージョン | 0.11.1 |
| OPENJPEG_VERSION | OpenJPEGのバージョン | 2.5.4 |
| LIBSPNG_VERSION | libspngのバージョン | 0.7.4 |
| LIBTIFF_VERSION | libtiffのバージョン | 4.7.1 |
| LIBAOM_VERSION | libaomのバージョン | 3.13.1 |
| LIBDE265_VERSION | libde265のバージョン | 1.0.16 |
| LIBX265_VERSION | libx265のバージョン | 4.1 |
| LIBHEIF_VERSION | libheifのバージョン | 1.20.2 |
| LIBWEBP_VERSION | libwebpのバージョン | 1.6.0 |
| LIBCGIF_VERSION | libcgifのバージョン | 0.5.0 |
| CAIRO_VERSION | Cairoのバージョン | 1.18.4 |
| LIBRSVG_VERSION | librsvgのバージョン | 2.61.1 |
| HARFBUZZ_VERSION | HarfBuzzのバージョン | 12.1.0 |
| BZIP2_VERSION | bzip2のバージョン | 1.0.8 |
| FREETYPE_VERSION | FreeTypeのバージョン | 2.14.1 |
| LIBXML2_VERSION | libxml2のバージョン | 2.15.0 |
| PANGO_VERSION | Pangoのバージョン | 1.57.0 |
| PIXMAN_VERSION | Pixmanのバージョン | 0.46.4 |
| ZLIB_VERSION | zlibのバージョン | 1.3.1 |
| LIBPNG_VERSION | libpngのバージョン | 1.6.50 |
| QUANTIZR_VERSION | quantizrのバージョン | 1.4.3 |
| ANDROID_SDK_ROOT | Android SDKのルートディレクトリ | $HOME/Android/Sdk |


## ビルド済みライブラリ

ビルド済みファイルは、デフォルトでは、**$HOME/local** に出力されます。  
共有ライブラリはその配下の **lib** ディレクトリ内にあります。ただし、出力するライブラリによっては、その配下にディレクトリが作成され配置されます。

後で取得しやすいように、**$HOME/dist** に **libvips** に必要な共有ライブラリをコピーしています。

```
$ ls -1 ~/dist
libbrotlicommon.so
libbrotlidec.so
libcairo.so
libcgif.so
libexpat.so
libffi.so
libfontconfig.so
libfreetype.so
libfribidi.so
libgio-2.0.so
libglib-2.0.so
libgmodule-2.0.so
libgobject-2.0.so
libharfbuzz.so
libiconv.so
libintl.so
libjpeg.so
libopenjp2.so
libpango-1.0.so
libpangocairo-1.0.so
libpangoft2-1.0.so
libpcre2-8.so
libpixman-1.so
libpng16.so
libquantizr.so
librsvg-2.so
libsharpyuv.so
libspng.so
libtiff.so
libwebp.so
libwebpdemux.so
libwebpmux.so
libxml2.so
libz.so
```