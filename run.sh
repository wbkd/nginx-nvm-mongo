#!/bin/env sh
set -e

PACKER_BIN="packer-io"
PACKER_BUILD="build.json"
SSH_PUB_KEY="$HOME/.ssh/id_rsa.pub"

cat $SSH_PUB_KEY > ./ansible/files/id_rsa.pub

$PACKER_BIN validate $PACKER_BUILD
$PACKER_BIN build $PACKER_BUILD

unset PACKER_BIN
unset PACKER_BUILD
unset SSH_PUB_KEY