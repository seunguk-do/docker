#!/bin/sh
container_name=$1
image=$2
version=$3
code_dir=$4
data_dir=$5
user=$USER
echo "containe_name: $container_name"
echo "image: $image"
echo "version: $version"
echo "code_dir: $code_dir"
echo "data_dir: $data_dir"
echo "user: $user"
docker run \
	-it \
	--name $container_name \
	--cpus=0.000 \
	--gpus=all \
	--ipc=host \
	--net=host \
	--shm-size=504g \
	-v $code_dir:/home/$user/codes \
	-v $data_dir:/home/$user/data \
	--workdir=/home/$user \
	$image:$version \
	zsh

