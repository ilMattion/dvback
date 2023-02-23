
function get_containers_of_volume() {
  docker ps -a --filter volume=$1 --format json | jq '.Image' | tr -d \" | tr \\n ,
}

function stop_containers() {
  for containerName in $(echo $1 | tr ",", " ");
  do
    stop_container $containerName
  done
}

function stop_container() {
  if [ $HOT_BACKUP == "0" ];
  then
    log_verbose "Stopping container $1"
    docker stop "$1"
  else
    log_warning "Hot backup is not raccomanded, are you sure?"
    exit 1
  fi
}

function start_container() {
  if [ $HOT_BACKUP == "0" ];
  then
    log_verbose "Starting $1 container"
    docker start "$1"
  fi
}

function backup_container() {
  CONTAINER_DESTINATION_MOUNT=$(docker container inspect "$1" | jq '.[0].Mounts[0].Destination'| tr -d \")
  CONTAINER_BACKUP_PATH="/backup/$1-$DATE_TIME_PREFIX-backup.tar"

  docker run --rm \
    --volumes-from "$1" \
    -v $BACKUP_FOLDER:/backup ubuntu tar cvf $CONTAINER_BACKUP_PATH $CONTAINER_DESTINATION_MOUNT
}
