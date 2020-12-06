#!/bin/bash

set -x
set -e

export CPPFLAGS="-DMDB_USE_ROBUST=0 -DDISABLE_X64"
export CFLAGS="-DMDB_USE_ROBUST=0 -DDISABLE_X64"

BASE_DIR=`pwd`
source $HOME/.cargo/env
export PATH="$BASE_DIR/rustpatch:/$BASE_DIR/rustbin/bin:$PATH"

set +e
rm -rf mwc713
set -e
git clone https://github.com/mwcproject/mwc713
pushd mwc713

rm ~/.cargo/config

echo "[target.aarch64-linux-android]"  >> ~/.cargo/config
echo "ar = \"$BASE_DIR/ndk_21/bin/aarch64-linux-android-ar\""  >> ~/.cargo/config
echo "linker = \"$BASE_DIR/ndk_21/bin/aarch64-linux-android-clang\""  >> ~/.cargo/config
echo "rustflags = [\"-C\", \"link-args=$BASE_DIR/ndk_21/sysroot/usr/lib/aarch64-linux-android/21/libc++.a\"]"  >> ~/.cargo/config
echo ""  >> ~/.cargo/config
echo "[target.x86_64-linux-android]"  >> ~/.cargo/config
echo "ar = \"$BASE_DIR/ndk_21/bin/x86_64-linux-android-ar\""  >> ~/.cargo/config
echo "linker = \"$BASE_DIR/ndk_21/bin/x86_64-linux-android-clang\""  >> ~/.cargo/config
echo "rustflags = [\"-C\", \"link-args=$BASE_DIR/ndk_21/sysroot/usr/lib/x86_64-linux-android/21/libc++.a\"]"  >> ~/.cargo/config

rustup target add aarch64-linux-android arm-linux-androideabi i686-linux-android x86_64-linux-android

PATH_ORIG="$PATH"

PATH="$PATH_ORIG:$BASE_DIR/ndk_21/bin"
cp $BASE_DIR/ndk_21/bin/arm64/*  $BASE_DIR/ndk_21/bin
# Tweak libc++_shared.so to static. By some reasons linker flag -lc++_static  doesn't work.
# So we are doing nasty hacking by copy static lib into dynamic. Compiler eats that
cp $BASE_DIR/ndk_21/sysroot/usr/lib/aarch64-linux-android/libc++_static.a  $BASE_DIR/ndk_19/sysroot/usr/lib/aarch64-linux-android/libc++_shared.so
cargo build --target=aarch64-linux-android --release

PATH="$PATH_ORIG:$BASE_DIR/ndk_21/bin"
cp $BASE_DIR/ndk_21/bin/x86_64/*  $BASE_DIR/ndk_21/bin
# Tweak libc++_shared.so to static. By some reasons linker flag -lc++_static  doesn't work.
# So we are doing nasty hacking by copy static lib into dynamic. Compiler eats that
cp $BASE_DIR/ndk_21/sysroot/usr/lib/x86_64-linux-android/libc++_static.a  $BASE_DIR/ndk_19/sysroot/usr/lib/x86_64-linux-android/libc++_shared.so
cargo build --target=x86_64-linux-android --release

PATH="$PATH_ORIG"

popd
