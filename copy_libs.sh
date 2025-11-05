#!/bin/bash

SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh

declare -a deps_list

get_deps() {
    local lib=$1
    local lib_path=$(find $PREFIX/lib -name "$lib" 2>/dev/null | head -1)
    if [ -n "$lib_path" ]; then
        local deps=$(readelf -d "$lib_path" 2>/dev/null | grep NEEDED | sed 's/.*\[//' | sed 's/\].*//')
        for dep in $deps; do
            if ! [[ " ${deps_list[@]} " =~ " $dep " ]]; then
                deps_list+=("$dep")
                get_deps $dep
            fi
        done
    fi
}

deps_list=()
get_deps libvips.so

mkdir -p $HOME/dist

for lib in "${deps_list[@]}"; do
    lib_path=$(find $PREFIX/lib -name "$lib" 2>/dev/null | head -1)
    if [ -n "$lib_path" ]; then
        cp "$lib_path" "$HOME/dist/"
        chmod 755 "$HOME/dist/$lib"
        echo "Copied $lib to $HOME/dist/ and set permissions to 755"
    fi
done

# Compress the dist folder into a tar.gz archive
tar czf $HOME/dist.tar.gz -C $HOME dist/
