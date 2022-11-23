ARG VERSION
FROM nvidia/cuda:$VERSION

ARG USER
ARG UID

# Add user
RUN useradd --create-home --shell /bin/bash --uid $UID --user-group -G sudo $USER

# Set timezone
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install basic programs
RUN apt-get update && apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get update && apt-get install -y \
    sudo zsh git wget curl vim tmux neovim htop ffmpeg libsm6 libxext6 tzdata \
    unzip autoconf automake pkg-config

RUN curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh && \
    bash /tmp/nodesource_setup.sh
RUN apt-get install nodejs

# Install ctags
RUN git clone https://github.com/universal-ctags/ctags.git && \
    cd ctags && \
    ./autogen.sh && \
    ./configure --prefix=/usr/local && \
    make && make install && \
    cd .. && rm -rf ctags

RUN sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
    git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# Copy config files
COPY .tmux.conf /root/
COPY .p10k.zsh /root/
COPY .zshrc /root/
COPY nvim /root/.config/nvim/

# Install tmux plugins
RUN mkdir -p /root/.tmux/plugins && \
    git clone https://github.com/tmux-plugins/tpm /root/.tmux/plugins/tpm && \
    tmux start-server && tmux new-session -d && \
    ./root/.tmux/plugins/tpm/scripts/install_plugins.sh && \
    tmux kill-session

# Copy installed plugin files to user's home directory
RUN mkdir -p /home/$USER/.config/nvim
RUN cp -r /root/.oh-my-zsh /home/$USER/.oh-my-zsh && \
    cp -r /root/.zshrc /home/$USER/.zshrc && \
    cp -r /root/.tmux.conf /home/$USER/.tmux.conf && \
    cp -r /root/.tmux /home/$USER/.tmux && \
    cp -r /root/.config/nvim /home/$USER/.config/ && \
    cp /root/.p10k.zsh /home/$USER/

RUN chown -R $USER:$USER /home/$USER/.oh-my-zsh && \
    chown $USER:$USER /home/$USER/.zshrc && \
    chown $USER:$USER /home/$USER/.tmux.conf && \
    chown -R $USER:$USER /home/$USER/.tmux && \
    chown -R $USER:$USER /home/$USER/.config && \
    chown $USER:$USER /home/$USER/.p10k.zsh

USER $USER
WORKDIR /home/$USER

# Install micromamba
RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
RUN ./bin/micromamba shell init -s zsh -p ~/micromamba
