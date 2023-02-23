#! /bin/bash

. loglib.sh
. dockerlib.sh
. configurations.config

log_verbose "Starting backup of containers: $DOCKER_CONTAINER_NAMES_TO_BACKUP"

for containerName in $(echo "$DOCKER_CONTAINER_NAMES_TO_BACKUP" | tr "," " "); 
do
  stop_container $containerName
  backup_container $containerName
  start_container $containerName
done
