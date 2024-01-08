#!/bin/bash

PWD=$(pwd -P)

docker run \
	-it \
	--gpus all \
	--name seunguk_dev \
	--shm-size 32G \
	--volume $HOME/projects:/home/user/projects \
	--volume /data0/seunguk/:/home/user/data \
	--volume $PWD/dotfiles/.zshrc:/home/user/.zshrc \
	--volume $PWD/dotfiles/.tmux.conf:/home/user/.tmux.conf \
	--volume $PWD/dotfiles/nvim:/home/user/.config/nvim \
	--volume $HOME/miniconda3/envs:/home/user/conda/envs \
	-p 7777:7777 \
	-p 8888:8888 \
	-p 9999:9999 \
	seunguk/cuda_dev \
	zsh
