#!/usr/bin/env bash

function install_zip() {
    apt install zip -y
}

[[ ! $HELP ]] && install_zip $@ || echo "apt install zip"