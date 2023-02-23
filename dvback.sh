#! /bin/bash

. loglib.sh
. dockerlib.sh
. configurations.config

log_verbose "Starting backup of volumes: $VOLUMES_TO_BACKUP"

for volumeName in $(echo "$VOLUMES_TO_BACKUP" | tr "," " ");
do
  log_verbose "Starting backup of volume: $volumeName"

  #CONTAINERS_OF_VOLUME=echo docker ps -a --filter volume=$volumeName --format json | jq '.Image' | tr -d \" | tr \\n ,
  CONTAINERS_OF_VOLUME=$(get_containers_of_volume $volumeName)
  log_verbose "$volumeName is mounted by this containers: $CONTAINERS_OF_VOLUME"
  # Fare il backup
  # Riavviare tutti i contenitori

 stop_containers $CONTAINERS_OF_VOLUME
 # backup_container $containerName
 # start_container $containerName
done
