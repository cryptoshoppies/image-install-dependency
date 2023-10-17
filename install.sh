#!/usr/bin/env bash

# VERSION
VERSION=0.0.3

# ARCH
ARCH=linux-$(uname -m)

# tag or branch
USE_TAG=true

# PARAMETERS
while [[ "$#" -gt 0 ]]; do
    case $1 in
    --version)
        export VERSION="$2"
        echo "VERSION=$VERSION"
        shift
        ;;
    --arch)
        export ARCH="$2"
        echo "ARCH=$ARCH"
        shift
        ;;
    --branch)
        export USE_TAG=false
        export VERSION="$2"
        echo "VERSION=$VERSION"
        [[ $USE_TAG ]] && echo "use tag" || echo "use branch"
        shift
        ;;
    --help)
        echo "Usage: $0 --version <version> --arch <linux-aarch64|linux-x86_64> --branch <branch> --help"
        exit 0
        ;;
    *)
        echo "Unknown parameter: $1"
        exit 1
        ;;
    esac
    shift
done

#-------------------------------------------------------------------------------------------------------
set -e
apt update
apt install zip -y

if [[ $USE_TAG ]]; then
    curl https://codeload.github.com/NeuralInnovations/runner-images/zip/refs/tags/$VERSION -o ./images.zip
else
    curl https://github.com/NeuralInnovations/runner-images/archive/refs/heads/$VERSION.zip -o ./images.zip
fi

unzip -o ./images.zip -d ./
cd ./runner-images-$VERSION
chmod -R 777 ./images/linux/
./images/linux/install.sh --arch $ARCH
cd ..
rm ./images.zip
rm ./image-install.sh
rm -fr ./runner-images-$VERSION
#-------------------------------------------------------------------------------------------------------