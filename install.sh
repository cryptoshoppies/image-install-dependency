#!/usr/bin/env bash

# VERSION
VERSION=0.0.3

# ARCH
ARCH=linux-$(uname -m)

# SOURCE_BY (tag|branch)
SOURCE_BY=tag

#-------------------------------------------------------------------------------------------------------
# PARAMETERS
while [[ "$#" -gt 0 ]]; do
    case $1 in
    --version)
        export VERSION="$2"
        shift
        ;;
    --arch)
        export ARCH="$2"
        shift
        ;;
    --branch)
        export SOURCE_BY=branch
        export VERSION="$2"
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

echo "----------------------------------------"
echo "VERSION=$VERSION"
echo "ARCH=$ARCH"
echo "SOURCE_BY=$SOURCE_BY"
echo "----------------------------------------"

#-------------------------------------------------------------------------------------------------------
set -e
apt update
apt install zip -y

if [[ "$SOURCE_BY" == "tag" ]]; then
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