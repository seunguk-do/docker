#!/bin/sh
container_name=$1
image=$2
version=$3
workspace_dir=$4
dataset_dir=$5
user=$USER
echo "containe_name: $container_name"
echo "image: $image"
echo "version: $version"
echo "workspace_dir: $workspace_dir"
echo "dataset_dir: $dataset_dir"
echo "user: $user"
docker run \
	-it \
	--name $container_name \
	--cpus=0.000 \
	--gpus=all \
	--ipc=host \
	--net=host \
	--shm-size=512gb \
	-v $workspace_dir:/home/$user/workspace \
	-v $dataset_dir:/home/$user/dataset \
	-v $HOME/.ssh:/home/$user/.ssh \
	--workdir=/home/$user \
	$image:$version \
	zsh
