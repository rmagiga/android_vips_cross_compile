#!/bin/bash

SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh

sudo apt update && sudo apt upgrade -y && sudo apt install make cmake autoconf automake libtool pkg-config libglib2.0-dev libssl-dev gettext unzip python3-pip python3-venv -y

cd ~
# ディレクトリがなければ、仮想環境作成
if [ ! -d "$VIRTUAL_ENV" ]; then
    echo "Creating python virtual environment: $VIRTUAL_ENV"
    python3 -m venv $VIRTUAL_NAME # env.shで仮想環境のPATH指定しているが、仮想環境のPythonがまだないので、デフォルトを使っている
    $VIRTUAL_ENV/bin/python3 -m pip install meson ninja tomli # わかりにくいのでpythonは絶対パスを指定
else
    echo "Python virtual environment already exists: $VIRTUAL_ENV"
fi

# rustがインストールされていなければインストール
if [ -d "$HOME/.cargo" ] && [ -d "$HOME/.rustup" ]; then
    echo "Rust is already installed."
else
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source ~/.bashrc
    rustup target add aarch64-linux-android
    unset CARGO_BUILD_TARGET
    cargo install cargo-c
fi
