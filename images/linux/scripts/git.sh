#!/usr/bin/env bash

function execute {
    apt install git -y
    apt install git-lfs -y
}

function help {
    echo "install git and git-lfs"
}
