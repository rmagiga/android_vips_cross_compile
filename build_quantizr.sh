#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

URL="https://github.com/DarthSim/quantizr/archive/refs/tags/v$QUANTIZR_VERSION.tar.gz"
DOWNLOAD_FILE=${DOWNLOADDIR}/quantizr-$QUANTIZR_VERSION.tar.gz
EXTRACT_DIR=$SRCDIR/quantizr-$QUANTIZR_VERSION

download $URL $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $EXTRACT_DIR

cd $EXTRACT_DIR

# Create .cargo/config.toml for cross-compilation
mkdir -p .cargo
cat > .cargo/config.toml << EOF
[build]
target = "$TARGET"

[target.$TARGET]
linker = "$CC"
rustflags = ["-L", "$SYSROOT/usr/lib/$TARGET/$ANDROID_API"]
EOF

export CARGO_BUILD_TARGET=$TARGET
cargo cinstall --target=$TARGET --prefix=$PREFIX --release