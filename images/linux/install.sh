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
install_script $SCRIPTS/zip.sh $@
install_script $SCRIPTS/apt-transport-https.sh $@
install_script $SCRIPTS/ca-certificates.sh $@
install_script $SCRIPTS/software-properties-common.sh $@
install_script $SCRIPTS/curl.sh $@
install_script $SCRIPTS/gnupg.sh $@
install_script $SCRIPTS/git.sh $@
install_script $SCRIPTS/docker.sh $@
install_script $SCRIPTS/sysconfig.sh $@
install_script $SCRIPTS/op.sh $@
install_script $SCRIPTS/aws.sh $@

echo_status
exit_status
