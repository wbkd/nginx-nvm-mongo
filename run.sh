#!/bin/env sh
set -e

PACKER_BIN="packer-io"
PACKER_BUILD="build.json"
SSH_PUB_KEY="$HOME/.ssh/id_rsa.pub"

BASEDIR=$(dirname $0)

cat $SSH_PUB_KEY > $BASEDIR/ansible/files/id_rsa.pub

# This script will delete all symlinks in this folder.
# Ir's a quickfix for the following bug:
# https://github.com/mitchellh/packer/issues/1627
cd $BASEDIR
find -type l -delete

$PACKER_BIN validate $PACKER_BUILD
$PACKER_BIN build $PACKER_BUILD

unset PACKER_BIN
unset PACKER_BUILD
unset BASEDIR
unset SSH_PUB_KEY