#!/bin/bash

set -x
set -e

chmod 400 ./uploader.pem


TAG_FOR_BUILD_FILE=mwc713.version
if [ -f "$TAG_FOR_BUILD_FILE" ]; then
VERSION=`cat $TAG_FOR_BUILD_FILE`
MWC713_NAME=mwc713_$VERSION
MWCZIP_NAME=mwczip_$VERSION
else
MWC713_NAME=mwc713_3.2.beta.$1
MWCZIP_NAME=mwczip_3.2.beta.$1
fi


function upload_file {
    DPKG_NAME=$1
    BIN_FN=$2
    TARGET=$3
    BIN_SUFFIX=$4
    PASS=$5

    BIN_NAME=${DPKG_NAME}_${BIN_SUFFIX}
	  cp mwc713/target/${TARGET}/release/${BIN_FN} $BIN_NAME
   	echo "md5sum = `md5sum $BIN_NAME`";
    ./scp.expect $BIN_NAME $PASS
}


mkdir -p ~/.ssh

upload_file $MWC713_NAME mwc713 aarch64-linux-android arm64 $2
upload_file $MWC713_NAME mwc713 x86_64-linux-android x86_64 $2

upload_file $MWCZIP_NAME mwczip aarch64-linux-android arm64 $2
upload_file $MWCZIP_NAME mwczip x86_64-linux-android x86_64 $2
