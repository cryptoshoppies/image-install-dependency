#!/usr/bin/env bash

set -e

# ---------------------------------------------------------
# constants
# ---------------------------------------------------------
DIR=./images/linux
SCRIPTS=$DIR/scripts

# ---------------------------------------------------------
# arguments
# ---------------------------------------------------------
source $DIR/tools/args.sh $@

argv --arch ARCH "<linux-aarch64|linux-x86_64>" $@
[[ ! $HELP ]] && [[ -z $ARCH ]] && echo "ARCH not set. Support only linux-aarch64|linux-x86_64" && exit 1

# ---------------------------------------------------------
# update
# ---------------------------------------------------------
apt update -y

# ---------------------------------------------------------
# install scripts
# ---------------------------------------------------------
$SCRIPTS/zip.sh $@
$SCRIPTS/curl.sh $@
$SCRIPTS/docker.sh $@
$SCRIPTS/sysconfig.sh $@
$SCRIPTS/op.sh $@
$SCRIPTS/aws.sh $@
