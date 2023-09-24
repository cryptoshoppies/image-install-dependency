#!/usr/bin/env bash

function install_curl() {
    apt install curl -y
}

[[ ! $HELP ]] && install_curl $@ || echo "apt install curl"