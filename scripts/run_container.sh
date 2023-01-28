#!/bin/sh
container_name=$1
image=$2
version=$3
project_dir=$4
data_dir=$5
user=$USER
cpus=$6
echo "containe_name: $container_name"
echo "image: $image"
echo "version: $version"
echo "project_dir: $project_dir"
echo "data_dir: $data_dir"
echo "user: $user"
docker run \
	-it \
	--name $container_name \
	--gpus=all \
	--ipc=host \
	--net=host \
	--shm-size=512gb \
	--cpuset-cpus=$cpus \
	-v $project_dir:/home/$user/Projects \
	-v $data_dir:/home/$user/Data \
	-v $HOME/.ssh:/home/$user/.ssh \
	--workdir=/home/$user \
	$user/$image:$version \
	zsh
