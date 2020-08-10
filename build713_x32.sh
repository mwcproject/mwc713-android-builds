#!/bin/bash

set -x

export CPPFLAGS="-DMDB_USE_ROBUST=0 -DDISABLE_X64"
export CFLAGS="-DMDB_USE_ROBUST=0 -DDISABLE_X64"

BASE_DIR=`pwd`
source $HOME/.cargo/env
export PATH="$BASE_DIR/rustpatch:/$BASE_DIR/rustbin/bin:$PATH"

git clone https://github.com/mwcproject/mwc713
pushd mwc713 

rm ~/.cargo/config

echo "[target.arm-linux-androideabi]" >> ~/.cargo/config
echo "ar = \"$BASE_DIR/ndk_19/bin/arm-linux-androideabi-ar\""  >> ~/.cargo/config
echo "linker = \"$BASE_DIR/ndk_19/bin/arm-linux-androideabi-clang\""  >> ~/.cargo/config
echo "rustflags = [\"-C\", \"link-args=-lc++\"]"  >> ~/.cargo/config
echo ""  >> ~/.cargo/config
echo "[target.i686-linux-android]"  >> ~/.cargo/config
echo "ar = \"$BASE_DIR/ndk_19/bin/i686-linux-android-ar\""  >> ~/.cargo/config
echo "linker = \"$BASE_DIR/ndk_19/bin/i686-linux-android-clang\""  >> ~/.cargo/config
echo "rustflags = [\"-C\", \"link-args=-lc++\"]"  >> ~/.cargo/config
echo ""  >> ~/.cargo/config

rustup target add arm-linux-androideabi i686-linux-android

PATH_ORIG="$PATH"

PATH="$PATH_ORIG:$BASE_DIR/ndk_19/bin"
cp $BASE_DIR/ndk_19/bin/arm/*  $BASE_DIR/ndk_19/bin
cargo build --target=arm-linux-androideabi --release

PATH="$PATH_ORIG:$BASE_DIR/ndk_19/bin"
cp $BASE_DIR/ndk_19/bin/i686/*  $BASE_DIR/ndk_19/bin
cargo build --target=i686-linux-android --release

PATH="$PATH_ORIG"

popd


