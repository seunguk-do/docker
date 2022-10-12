#!/bin/sh
echo "Username: $USER";
echo "UID: $(id -u $USER)";
echo "Image: $1";
echo "Version: $2";

docker build \
	-t $USER/$1:$2 \
	--build-arg VERSION=$2 \
	--build-arg USER=$USER \
	--build-arg UID=$(id -u $USER) \
	./dockerfiles/$1
