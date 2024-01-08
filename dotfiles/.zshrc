# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="spaceship"

# Specify the plugins to use
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration
## Set language environment
export LANG=en_US.UTF-8

# Aliases
alias vim="nvim"

# Functions
function switch_cuda {
  v=$1
  sudo ln -sfT /usr/local/cuda-$v/ /usr/local/cuda
  nvcc --version
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/user/conda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/user/conda/etc/profile.d/conda.sh" ]; then
        . "/home/user/conda/etc/profile.d/conda.sh"
    else
        export PATH="/home/user/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

