#!/bin/bash

# Executes a script on each machine in the machine list
#
# USAGE:
#   . execute-command-for-each.sh <SCRIPT> <MACHINE_LIST> "<ARGS>"
#
# ARGS:
#   SCRIPT - script to execute
#   MACHINE_LIST - file with list of IPs or resolvable machine names to target
#   ARGS - arguments to be passed to $SCRIPT when executing. For multiple arguments,
#          be sure to encapsulate arguments in quotes "ARGS".

SCRIPT=$1
MACHINE_LIST=$2
ARGS=$3
USER='root'
while IFS= read -r LINE
do
  for TARGETIP in "${LINE[@]}"; do
    echo "Executing $SCRIPT on $TARGETIP"
    ssh < $SCRIPT "$USER"@"$TARGETIP" "bash -s -- $ARGS"
  done
done < "$MACHINE_LIST"
