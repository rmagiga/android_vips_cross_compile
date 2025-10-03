# Android用のlibvipsをクロスコンパイルするプロジェクト

## 環境

- Windows 11 25H2
- WSL2
- Ubuntu 22.04

## WSL上にUbuntuをインストール

```
wsl --install -d Ubuntu-22.04
```

ユーザーは、ubuntu。

## Ubuntu パッケージ設定

ビルドに必要なパッケージのインストール
```
sudo apt update && sudo apt upgrade -y
sudo apt install build-essential pkg-config libglib2.0-dev libexpat1-dev python3-pip unzip -y
```

mesonとninjaのインストール
```
python3 -m pip install meson ninja
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## libvipsのビルド・インストール

./build_libvips.sh
