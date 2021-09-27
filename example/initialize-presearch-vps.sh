#!/bin/bash

# Example commands to initialize presearch VPS nodes. The specific commands are
# tailored to CentOS, but you can plug in equivalent commands for your target OS.

# Copy ssh keys to each node
../copy-ssh-key.sh ~/.ssh/presearch-cluster node_password_list.sample

# Install docker on each node
../execute-script.sh node_list.sample install-docker.sh

# Start docker on each node
../execute-command.sh node_list.sample "systemctl start docker"

# Enable docker service on each node
../execute-command.sh node_list.sample "sudo systemctl enable /usr/lib/systemd/system/docker.service"

# Start PRE docker container
../execute-script.sh node_list.sample start-presearch-docker-container.sh "myRegistrationCode"

