#!/usr/bin/env bash

# VERSION
VERSION=0.0.3

# ARCH
ARCH=linux-$(uname -m)

#-------------------------------------------------------------------------------------------------------
set -e
apt update
apt install zip -y
curl https://codeload.github.com/NeuralInnovations/runner-images/zip/refs/tags/$VERSION -o ./images.zip
unzip -o ./images.zip -d ./
cd ./runner-images-$VERSION
chmod -R 777 ./images/linux/
./images/linux/install.sh --arch $ARCH
cd ..
rm ./images.zip
rm ./image-install.sh
rm -fr ./runner-images-$VERSION
#-------------------------------------------------------------------------------------------------------