#!/usr/bin/env bash

function execute {
    apt install apache2-utils -y
}

function help {
    echo "install apache2-utils (htpasswd)"
}
