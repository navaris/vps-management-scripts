#!/bin/bash

# Starts/Restarts the Presearch docker container
#
# ARGS:
#   REGISTRATION_CODE - registration code from your presearch profile

REGISTRATION_CODE=$1

docker stop presearch-node ; docker rm presearch-node ; docker stop presearch-auto-updater ; docker rm presearch-auto-updater ; docker run -d --name presearch-auto-updater --restart=unless-stopped -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --cleanup --interval 300 presearch-node ; docker pull presearch/node ; docker run -dt --name presearch-node --restart=unless-stopped -v presearch-node-storage:/app/node -e REGISTRATION_CODE=$REGISTRATION_CODE presearch/node ; docker logs -f presearch-node
