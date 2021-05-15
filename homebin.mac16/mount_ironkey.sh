#!/bin/bash

IRONKEY_MOUNT="/tmp/${USER}-ironkey"
[[ ! -d ${IRONKEY_MOUNT} ]] && mkdir ${IRONKEY_MOUNT}

diskutil unmount /dev/disk2
mount_msdos -u ${USER} -m 700 /dev/disk2 ${IRONKEY_MOUNT}

eval `ssh-agent-prod`
export SSH_ADD="ssh-add-prod"
