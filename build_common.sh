#!/bin/bash

# ダウンロード
# 引数: URL, 出力ファイル名
download() {
    local url="$1"
    local output="$2"
    
    # 既にファイルが存在する場合はスキップ
    if [ -f "$output" ]; then
        echo "File already exists, skipping download: $output"
        return 0
    fi
    
    mkdir -p "$(dirname "$output")"
    curl -L -o "$output" "$url"
}

# 解凍
# 引数: アーカイブファイル, 出力ディレクトリ
extract() {
    local archive="$1"
    local output_dir="$2"
    mkdir -p "$output_dir"
    case "$archive" in
        *.tar.gz | *.tgz) tar -xzf "$archive" -C "$output_dir" --strip-components=1 ;;
        *.tar.bz2 | *.tbz2) tar -xjf "$archive" -C "$output_dir" --strip-components=1 ;;
        *.tar.xz | *.txz) tar -xJf "$archive" -C "$output_dir" --strip-components=1 ;;
        *.zip) unzip -q "$archive" -d "$output_dir" ;;
        *) echo "Unsupported archive format: $archive" ; exit 1 ;;
    esac
}

create_cross_file() {
    local template_file="$1"
    local cross_file="$2"
sed \
  -e "s|{{ANDROID_API}}|$ANDROID_API|g" \
  -e "s|{{TARGET}}|$TARGET|g" \
  -e "s|{{TOOLCHAIN}}|$TOOLCHAIN|g" \
  -e "s|{{PREFIX}}|$PREFIX|g" \
  -e "s|{{LIBDIR}}|$LIBDIR|g" \
  -e "s|{{INCLUDEARGS}}|$INCLUDEARGS|g" \
  $template_file > $cross_file
}