#! /bin/bash

. loglib.sh
. dockerlib.sh
. configurations.config

log_information "Starting backup of volumes: $VOLUMES_TO_BACKUP"

for volumeName in $(echo "$VOLUMES_TO_BACKUP" | tr "," " ");
do
  BACKUP_FILE_NAME = $volumeName + "-" + $DATE_TIME_PREFIX
  log_information "Starting backup of volume: $volumeName in $BACKUP_FOLDER with file name $BACKUP_FILE_NAME"

  backup_volume $volumeName $BACKUP_FOLDER $BACKUP_FILE_NAME

  # Riavviare tutti i contenitori

 #stop_containers $CONTAINERS_OF_VOLUME
 # backup_container $containerName
 # start_container $containerName
done
