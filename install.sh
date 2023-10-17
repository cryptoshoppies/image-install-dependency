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
function echo_red {
    echo -e "\033[0;31m$1\033[0m"
}
function echo_green {
    echo -e "\033[0;32m$1\033[0m"
}
function echo_yellow {
    echo -e "\033[0;33m$1\033[0m"
}
function echo_blue {
    echo -e "\033[0;34m$1\033[0m"
}
function echo_line {
    echo_blue "----------------------------------------"
}
#-------------------------------------------------------------------------------------------------------
if [[ "$SOURCE_BY" == "tag" ]]; then
    export URL=https://codeload.github.com/NeuralInnovations/runner-images/zip/refs/tags/$VERSION
else
    export URL=https://github.com/NeuralInnovations/runner-images/archive/refs/heads/$VERSION.zip
fi
#-------------------------------------------------------------------------------------------------------

echo_line
echo_blue "VERSION=$VERSION"
echo_blue "ARCH=$ARCH"
echo_blue "SOURCE_BY=$SOURCE_BY"
echo_blue "URL=$URL"
echo_line

#-------------------------------------------------------------------------------------------------------
set -e

echo_line
    apt update
echo_line
    apt install zip -y
echo_line
    curl $URL-o ./images.zip
echo_line
    unzip -o ./images.zip -d ./
echo_line
    cd ./runner-images-$VERSION
    chmod -R 777 ./images/linux/
echo_line
    ./images/linux/install.sh --arch $ARCH
echo_line
    cd ..
echo_line
    rm ./images.zip
echo_line
    rm ./image-install.sh
echo_line
    rm -fr ./runner-images-$VERSION
echo_line
echo_green "DONE"
#-------------------------------------------------------------------------------------------------------