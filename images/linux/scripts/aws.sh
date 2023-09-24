#!/usr/bin/env bash

function install_aws() {
    [[ -z $ARCH ]] && echo "ARCH not set. Support only linux-aarch64|linux-x86_64" && exit 1

    curl "https://awscli.amazonaws.com/awscli-exe-$ARCH.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
}

[[ ! $HELP ]] && install_aws $@ || echo "install aws cli"