#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
. $SCRIPTDIR/env.sh
. $SCRIPTDIR/build_common.sh

URL="https://sourceware.org/pub/bzip2/bzip2-$BZIP2_VERSION.tar.gz"
DOWNLOAD_FILE=${DOWNLOADDIR}/bzip2-$BZIP2_VERSION.tar.gz
EXTRACT_DIR=$SRCDIR/bzip2-$BZIP2_VERSION

download $URL $DOWNLOAD_FILE
extract $DOWNLOAD_FILE $EXTRACT_DIR

cd $EXTRACT_DIR

cp Makefile{,.orig}
sed -e "/^all:/s/ test//" Makefile.orig > Makefile
sed -i -e 's:ln -s -f $(PREFIX)/bin/:ln -s :' Makefile
make -f Makefile-libbz2_so CC="${CC}" AR="${AR}" RANLIB="${RANLIB}"
make clean

make CC="${CC}" AR="${AR}" RANLIB="${RANLIB}"
make PREFIX=${PREFIX} install
