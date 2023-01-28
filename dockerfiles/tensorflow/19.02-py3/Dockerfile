FROM nvcr.io/nvidia/tensorflow:19.02-py3

ARG USER
ARG UID

# Add user
RUN useradd --create-home --shell /bin/bash --uid $UID --user-group -G sudo $USER

# Set timezone
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install basic programs
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    sudo zsh git wget curl vim tmux htop ffmpeg libsm6 libxext6 tzdata \
    unzip autoconf automake pkg-config

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh && \
    bash /tmp/nodesource_setup.sh && \
    apt-get install -y nodejs

# Install ctags
RUN git clone https://github.com/universal-ctags/ctags.git && \
    cd ctags && \
    ./autogen.sh && \
    ./configure --prefix=/usr/local && \
    make && make install && \
    cd .. && rm -rf ctags

# Install Bottom
RUN curl -LO https://github.com/ClementTsang/bottom/releases/download/0.6.8/bottom_0.6.8_amd64.deb && \
    sudo dpkg -i bottom_0.6.8_amd64.deb

USER $USER
WORKDIR /home/$USER

# Install oh-my-zh and plugins of it
RUN sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
    git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# Copy configuration files to user's home directory
COPY --chown=$USER:$USER .tmux.conf /home/$USER/
COPY --chown=$USER:$USER .p10k.zsh /home/$USER/
COPY --chown=$USER:$USER .zshrc /home/$USER/

# Install tmux plugins
RUN mkdir -p /home/$USER/.tmux/plugins && \
    git clone https://github.com/tmux-plugins/tpm /home/$USER/.tmux/plugins/tpm && \
    tmux start-server && tmux new-session -d && \
    /home/$USER/.tmux/plugins/tpm/scripts/install_plugins.sh && \
    tmux kill-session

# Install micromamba
RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba && \
    ./bin/micromamba shell init -s zsh -p ~/micromamba
