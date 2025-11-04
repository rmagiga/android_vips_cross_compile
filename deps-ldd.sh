#!/bin/bash

SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh

get_deps() {
    local lib=$1
    local lib_path=$(find $PREFIX/lib -name "$lib" 2>/dev/null | head -1)
    if [ -n "$lib_path" ]; then
        readelf -d "$lib_path" 2>/dev/null | grep NEEDED | sed 's/.*\[//' | sed 's/\].*//' | while read dep; do
            if ! echo "$all_deps" | grep -q "^$dep$"; then
                all_deps="$all_deps$dep\n"
                echo $dep
                get_deps $dep
            fi
        done
    fi
}

all_deps=""
get_deps libvips.so | sort | uniq
