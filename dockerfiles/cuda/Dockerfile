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
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:neovim-ppa/unstable && \
    apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    sudo zsh git wget curl vim tmux neovim htop ffmpeg libsm6 libxext6 tzdata \
    unzip autoconf automake pkg-config build-essential libssl-dev liblzma-dev \
    bzip2 libncurses5-dev libncursesw5-dev libffi-dev sqlite3 zlib1g-dev \
    libsqlit3-dev libffi-dev libbz2-dev libreadline-dev

# Fix locale error
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y locales \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh && \
    bash /tmp/nodesource_setup.sh && \
    apt-get install -y nodejs

USER $USER
WORKDIR /home/$USER

# Install oh-my-zsh and plugins of it
RUN sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
    git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# Copy configuration files to user's home directory
RUN mkdir -p /home/$USER/.config/nvim
COPY --chown=$USER:$USER dotfiles/.tmux.conf /home/$USER/
COPY --chown=$USER:$USER dotfiles/.p10k.zsh /home/$USER/
COPY --chown=$USER:$USER dotfiles/.zshrc /home/$USER/
COPY --chown=$USER:$USER dotfiles/nvim /home/$USER/.config/nvim/

# Install pyenv
RUN curl https://pyenv.run | bash
