#! /bin/bash

. loglib.sh
. dockerlib.sh
. configurations.config

if [ $HOT_BACKUP == "1" ];
then
  log_warning "Hot backup is not raccomanded. It can cause inconsistent backups."
fi

log_information "Starting backup of volumes: $VOLUMES_TO_BACKUP"
for volumeName in $(echo "$VOLUMES_TO_BACKUP" | tr "," " ");
do

  BACKUP_FILE_NAME=$volumeName"-"$DATE_TIME_PREFIX
  VOLUME_CONTAINERS=$(get_volume_containers $volumeName)

  if [ $HOT_BACKUP == "0" ];
  then
    log_information "Stopping containers $VOLUME_CONTAINERS"
    stop_containers $VOLUME_CONTAINERS
  fi

  log_information "Starting backup of volume: $volumeName in $BACKUP_FOLDER with file name $BACKUP_FILE_NAME"
  backup_volume $volumeName $BACKUP_FOLDER $BACKUP_FILE_NAME

  start_containers $VOLUME_CONTAINERS

  if [ $HOT_BACKUP == "0" ];
  then
    log_verbose "Starting containers $VOLUME_CONTAINERS"
    start_containers $VOLUME_CONTAINERS
  fi

done
