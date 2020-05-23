# mwc713-android-builds

Repository for mwc713 Android Builds. 
Here we have everythign to build mwc713 for Android. Supporting 4 ABI:  x86, x86-64, arm, arm64

setup_linux.sh  - install rust and needed ubuntu packages

build713.sh - build mwc713 for all four Android ABI

deploy_linux.sh - upload to nightly build server

----------------------

How to compress:
tar cvfj helpers/rustbin/rustbin.tar.bz2  rustbin
split -b 40m -a 3 helpers/rustbin/rustbin.tar.bz2 helpers/rustbin/rustbin_
rm helpers/rustbin/rustbin.tar.bz2

Results at helpers/rustbin/: rustbin_aaa  rustbin_aab  rustbin_aac  rustbin_aad  rustbin_aae

Do the same for NDKs


How to extract:
cat helpers/rustbin/rustbin_* | bzip2 -dc | tar xvf -
cat helpers/ndk_19/ndk_19_* | bzip2 -dc | tar xvf -
cat helpers/ndk_21/ndk_21_* | bzip2 -dc | tar xvf -
