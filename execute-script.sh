#!/bin/bash

# Executes a script on each node in the list
#
# USAGE:
#   . execute-script.sh <NODES> <SCRIPT> "<ARGS>"
#   . execute-script.sh /path/to/node_list test-script.sh "one two"
#
# ARGS:
#   NODES   - file with list of IPs or resolvable machine names to target
#   SCRIPT  - script to execute
#   ARGS    - arguments to be passed to $SCRIPT when executing. For multiple arguments,
#             be sure to encapsulate arguments in quotes "ARGS".

NODES=$1
SCRIPT=$2
ARGS=$3
USER='root'
while IFS= read -r LINE
do
  for TARGETIP in "${LINE[@]}"; do
    echo "Executing $SCRIPT on $TARGETIP"
    ssh < $SCRIPT "$USER"@"$TARGETIP" "bash -s -- $ARGS"
  done
done < "$NODES"
