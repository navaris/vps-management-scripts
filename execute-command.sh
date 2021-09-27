#!/bin/bash

# Executes a command on each node in the list
#
# USAGE:
#   . execute-command.sh <NODES> "<COMMAND>"
#   . execute-command.sh /path/to/node_list "echo Hello from inside the node"
#
# ARGS:
#   NODES - file with list of IPs or resolvable machine names to target
#   COMMAND - command to execute on each node

NODES=$1
COMMAND=$2
USER='root'
while IFS= read -r LINE
do
  for TARGETIP in "${LINE[@]}"; do
    echo "Executing $COMMAND on $TARGETIP"
    echo $COMMAND | ssh "$USER"@"$TARGETIP" "bash -s --"
  done
done < "$NODES"
