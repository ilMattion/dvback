#! /bin/bash

. loglib.sh
. dockerlib.sh
. configurations.config

log_information "Starting backup of volumes: $VOLUMES_TO_BACKUP"

for volumeName in $(echo "$VOLUMES_TO_BACKUP" | tr "," " ");
do
  BACKUP_FILE_NAME=$volumeName+"-"+$DATE_TIME_PREFIX
  VOLUME_CONTAINERS=$(get_volume_containers $volumeName)

  stop_containers $VOLUME_CONTAINERS

  log_information "Starting backup of volume: $volumeName in $BACKUP_FOLDER with file name $BACKUP_FILE_NAME"
  backup_volume $volumeName $BACKUP_FOLDER $BACKUP_FILE_NAME

  start_containers $VOLUME_CONTAINERS

done
