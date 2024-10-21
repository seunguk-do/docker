ARG USER_ID=1008
ARG USER=seunguk
FROM nvcr.io/nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04
ARG USER_ID
ARG USER

# Set non-interactive to prevent asking for user inputs blocking image creation.
ENV DEBIAN_FRONTEND=noninteractive
ENV CUDA_HOME="/usr/local/cuda"
ARG CUDA_ARCHITECTURES=89;86

#-------------------------------------------------------------------------------
# Install required apt packages
#-------------------------------------------------------------------------------
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
	zsh \
	tmux \
	tzdata \
	locales \
	build-essential \
	cmake \
	curl \
	wget \
	ffmpeg \
	git \
	sudo \
	unzip \
	htop \
	pkg-config \
	cmake \
	curl \
	gnupg \
	zlib1g-dev \
	libbz2-dev \
	libffi-dev \
	libreadline-dev \
	liblzma-dev \
	libssl-dev \
	libsqlite3-dev \
	pciutils

#-------------------------------------------------------------------------------
# Setting for locale
#-------------------------------------------------------------------------------
RUN echo "en_US.UTF-8 UTF-8" >/etc/locale.gen && locale-gen

# Create non root user and setup environment.
RUN useradd -m -d /home/$USER -g root -G sudo -u ${USER_ID} ${USER} && \
    usermod -aG sudo $USER
## Ensure sudo group users are not asked for a password when using sudo command by ammending sudoers file
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Switch to new user and workdir.
USER ${USER_ID}
WORKDIR /home/$USER

RUN curl -Lo /home/$USER/miniconda3.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash /home/$USER/miniconda3.sh -b -u -p /home/$USER/miniconda3
