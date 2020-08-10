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
echo "[target.aarch64-linux-android]"  >> ~/.cargo/config
echo "ar = \"$BASE_DIR/ndk_21/bin/aarch64-linux-android-ar\""  >> ~/.cargo/config
echo "linker = \"$BASE_DIR/ndk_21/bin/aarch64-linux-android-clang\""  >> ~/.cargo/config
echo "rustflags = [\"-C\", \"link-args=-lc++\"]"  >> ~/.cargo/config
echo ""  >> ~/.cargo/config
echo "[target.x86_64-linux-android]"  >> ~/.cargo/config
echo "ar = \"$BASE_DIR/ndk_21/bin/x86_64-linux-android-ar\""  >> ~/.cargo/config
echo "linker = \"$BASE_DIR/ndk_21/bin/x86_64-linux-android-clang\""  >> ~/.cargo/config
echo "rustflags = [\"-C\", \"link-args=-lc++\"]"  >> ~/.cargo/config

rustup target add aarch64-linux-android arm-linux-androideabi i686-linux-android x86_64-linux-android

PATH_ORIG="$PATH"

PATH="$PATH_ORIG:$BASE_DIR/ndk_21/bin"
cp $BASE_DIR/ndk_21/bin/arm64/*  $BASE_DIR/ndk_21/bin
cargo build --target=aarch64-linux-android --release

PATH="$PATH_ORIG:$BASE_DIR/ndk_21/bin"
cp $BASE_DIR/ndk_21/bin/x86_64/*  $BASE_DIR/ndk_21/bin
cargo build --target=x86_64-linux-android --release

PATH="$PATH_ORIG"

popd
