ARG CUDA_VERSION=12.3.1
ARG OS_VERSION=22.04
ARG USER_ID=1007
# Define base image.
FROM nvidia/cuda:${CUDA_VERSION}-devel-ubuntu${OS_VERSION}
ARG CUDA_VERSION
ARG OS_VERSION
ARG USER_ID

# Set environment variables.
## Set non-interactive to prevent asking for user inputs blocking image creation.
ENV DEBIAN_FRONTEND=noninteractive
## Set timezone as it is required by some packages.
ENV TZ=Asia/Seoul
## Set langauge
ENV LC_ALL=C.UTF-8
## CUDA Home, required to find CUDA in some packages.
ENV CUDA_HOME="/usr/local/cuda"
## Conda path
ENV PATH /home/user/conda/bin:$PATH
## zsh custom directory
ENV ZSH_CUSTOM=/home/user/.oh-my-zsh/custom

# Install required apt packages and clear cache afterwards.
RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential
RUN apt-get install -y --no-install-recommends cmake
RUN apt-get install -y --no-install-recommends curl
RUN apt-get install -y --no-install-recommends wget
RUN apt-get install -y --no-install-recommends ffmpeg
RUN apt-get install -y --no-install-recommends git
RUN apt-get install -y --no-install-recommends sudo
RUN apt-get install -y --no-install-recommends unzip
RUN apt-get install -y --no-install-recommends htop
RUN apt-get install -y --no-install-recommends zsh
RUN apt-get install -y --no-install-recommends tmux
RUN apt-get install -y --no-install-recommends libfuse2
RUN apt-get install -y --no-install-recommends libxml2-dev
RUN rm -rf /var/lib/apt/lists/*

# Install additional cuda versions
## Install cuda 11.7
## wget https://developer.download.nvidia.com/compute/cuda/11.7.1/local_installers/cuda_11.7.1_515.65.01_linux.run
COPY cuda_installers /cuda_installers
RUN sh cuda_installers/cuda_11.7.1_515.65.01_linux.run --silent --toolkit --toolkitpath=/usr/local/cuda-11.7

# Create non root user and setup environment.
RUN useradd -m -d /home/user -g root -G sudo -u ${USER_ID} user && \
    usermod -aG sudo user
## Set user password
RUN echo "user:user" | chpasswd
## Ensure sudo group users are not asked for a password when using sudo command by ammending sudoers file
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Switch to new user and workdir.
USER ${USER_ID}
WORKDIR /home/user

# Install required dev tools

## Install neovim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x ./nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    sudo mv squashfs-root / && \
    sudo ln -s /squashfs-root/AppRun /usr/bin/nvim && \
    rm ./nvim.appimage

## Install NodeJS
RUN sudo apt-get install -y ca-certificates curl gnupg
RUN sudo mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
RUN sudo apt-get update && sudo apt-get install nodejs -y

# Install oh-my-zsh, theme, and plugins
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1 && \
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
RUN git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

## install miniconda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py311_23.5.2-0-Linux-x86_64.sh -O ~/miniconda.sh && \
    bash ~/miniconda.sh -b -p /home/user/conda && \
	  rm ~/miniconda.sh
RUN conda init zsh

RUN mkdir /home/user/.config
