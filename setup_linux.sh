#!/bin/sh


# Add deps
sudo apt update
sudo apt-get install expect

sudo apt-get install g++-multilib libc6-dev-i386
sudo apt-get install libc6-i386 lib32z1 lib32stdc++6

# installing OpenSSL
#sudo apt install build-essential checkinstall zlib1g-dev -y
#sudo wget https://www.openssl.org/source/openssl-1.1.1g.tar.gz
#sudo tar -xf openssl-1.1.1g.tar.gz
#cd openssl-1.1.1g
#sudo ./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib
#sudo make install
#cd ..
# open ssl is done

# Update rust
curl https://sh.rustup.rs -sSf | bash -s -- -y

# preparing custom rust build
cat helpers/rustbin/rustbin_* | bzip2 -dc | tar xvf -
cat helpers/ndk_19/ndk_19_* | bzip2 -dc | tar xvf -
cat helpers/ndk_21/ndk_21_* | bzip2 -dc | tar xvf -

