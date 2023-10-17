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
[[ ! $HELP ]] && apt update -y

# ---------------------------------------------------------
# install scripts
# ---------------------------------------------------------
install $SCRIPTS/zip.sh $@
install $SCRIPTS/apt-transport-https.sh $@
install $SCRIPTS/ca-certificates.sh $@
install $SCRIPTS/software-properties-common.sh $@
install $SCRIPTS/curl.sh $@
install $SCRIPTS/gnupg.sh $@
install $SCRIPTS/git.sh $@
install $SCRIPTS/docker.sh $@
install $SCRIPTS/sysconfig.sh $@
install $SCRIPTS/op.sh $@
install $SCRIPTS/aws.sh $@

echo_status
