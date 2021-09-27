#!/bin/bash

# Copies ssh key to machines listed in $NODE_PW_LIST
#
# USAGE
#   . copy-ssh-key.sh <KEY_LOCATION> <NODE_PW_LIST>
#   . copy-ssh-key.sh ~/.ssh/path/to/ssh/key ./path/to/machine/list
#
# ARGS:
#   KEY_LOCATION - ssh key file to copy
#   NODE_PW_LIST - file with list of IPs or resolvable machine names to target

KEY_LOCATION=$1
NODE_PW_LIST=$2
USER='root'
while IFS= read -r LINE
do
  for i in "${LINE[@]}"; do
    SEGMENTS=(${i// / })
    TARGETIP=${SEGMENTS[0]}
    USERPASS=${SEGMENTS[1]}
    echo "Copying $KEY_LOCATION to $TARGETIP"
    sshpass -p $USERPASS ssh-copy-id -i $KEY_LOCATION "$USER"@"$TARGETIP"
  done
done < "$NODE_PW_LIST"
