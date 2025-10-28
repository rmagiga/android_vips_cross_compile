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
- Ubuntu 22.04

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
./build_all.sh
```