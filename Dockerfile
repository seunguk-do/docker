ARG USER_ID=1008
ARG USER=seunguk
FROM nvidia/cuda:12.3.1-devel-ubuntu22.04
ARG USER_ID
ARG USER

# Set environment variables.
## Set non-interactive to prevent asking for user inputs blocking image creation.
ENV DEBIAN_FRONTEND=noninteractive
## Set timezone as it is required by some packages.
ENV TZ=Asia/Seoul
## Set langauge
ENV LC_ALL=C.UTF-8
## CUDA Home, required to find CUDA in some packages.
ENV CUDA_HOME="/usr/local/cuda"

# Install required apt packages and clear cache afterwards.
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    tzdata \
    build-essential \
    cmake \
    curl \
    wget \
    ffmpeg \
    git \
    sudo \
    unzip \
    htop \
    zsh \
    tmux \
    pkg-config \
    cmake \
    curl \
    gnupg \
    python3.10 \
    python3-pip \
    python3.10-venv \
    python3-dev \
    python3-pybind11
RUN rm -rf /var/lib/apt/lists/*

RUN python3.10 -m pip install pipenv nvitop

# Install LazyGit
RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') && \
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
RUN tar xf lazygit.tar.gz lazygit
RUN sudo install lazygit /usr/local/bin && rm lazygit.tar.gz lazygit

## Install NodeJS
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
RUN sudo apt-get update && sudo apt-get install nodejs -y

## Install neovim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x ./nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    sudo ln -s /squashfs-root/AppRun /usr/bin/nvim && \
    rm ./nvim.appimage

# Create non root user and setup environment.
RUN useradd -m -d /home/$USER -g root -G sudo -u ${USER_ID} ${USER} && \
    usermod -aG sudo $USER
## Set user password
RUN echo "$USER:$USER" | chpasswd
## Ensure sudo group users are not asked for a password when using sudo command by ammending sudoers file
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Switch to new user and workdir.
USER ${USER_ID}
WORKDIR /home/$USER

# Install oh-my-zsh, theme, and plugins
ENV ZSH_CUSTOM="/home/$USER/.oh-my-zsh/custom"
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1 && \
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
RUN git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

RUN mkdir /home/$USER/.config && \
    mkdir /home/$USER/projects
