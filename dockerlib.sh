
#######################################
# Return all docker containers of a
# volume.
# Arguments:
#   Volume name
#
#######################################
function get_volume_containers() {
  docker ps -a --filter volume=$1 --format json | jq '.Image' | tr -d \" | tr \\n ,
}

function stop_containers() {
  for containerName in $(echo $1 | tr ",", " ");
  do
    docker stop $containerName
  done
}

function start_containers() {
  for containerName in $(echo $1 | tr ",", " ");
  do
    docker start $containerName
  done
}

#######################################
# Perform backup of a docker container
# Arguments:
#   Docker volume name
#   Backup folder
#   Backup file name
#######################################
function backup_volume() {
  # TODO: if backup file name has extension remove
  # TODO: check if already exists a backup
  log_verbose "Starting backup of volume $1 in path $2 with file name $3"
  docker run --rm \
	-v $1:/volume \
	-v $2:/backup \
	ubuntu tar cf /backup/$3.tar /volume
}
