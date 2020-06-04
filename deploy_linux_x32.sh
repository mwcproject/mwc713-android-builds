#!/bin/bash

set -x

chmod 400 ./uploader.pem


TAG_FOR_BUILD_FILE=mwc713.version
if [ -f "$TAG_FOR_BUILD_FILE" ]; then
VERSION=`cat $TAG_FOR_BUILD_FILE`
DPKG_NAME=mwc713_$VERSION
else
DPKG_NAME=mwc713_3.2.beta.$1
fi


function upload_file {
    TARGET=$1 
    BIN_SUFFIX=$2

    BIN_NAME=${DPKG_NAME}_${BIN_SUFFIX}
	cp mwc713/target/${TARGET}/release/mwc713 $BIN_NAME
	echo "md5sum = `md5sum $BIN_NAME`";
        ./scp.expect $BIN_NAME $2
}  


mkdir -p ~/.ssh

upload_file arm-linux-androideabi arm
upload_file i686-linux-android x86

