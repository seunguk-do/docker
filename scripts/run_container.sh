#!/bin/bash

PWD=$(pwd -P)

docker run \
	-it \
	--gpus all \
	--hostname seunguk_dev \
	--name seunguk_dev \
	--shm-size 512G \
	--volume $HOME/projects:/home/seunguk/projects \
	--volume /data0/seunguk/:/home/seunguk/data \
	--volume $PWD/dotfiles/zshrc:/home/seunguk/.zshrc \
	--volume $PWD/dotfiles/tmux:/home/seunguk/.config/tmux \
	--volume $PWD/dotfiles/nvim:/home/seunguk/.config/nvim \
	-p 7777:7777 \
	-p 9999:9999 \
	seunguk/cuda_dev \
	zsh
