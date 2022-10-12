export LANG='en_US.UTF-8'
export LANGUAGE='en_US:en'
export LC_ALL='en_US.UTF-8'
export TERM='xterm-256color'

##### Zsh/Oh-my-Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git sudo zsh-autosuggestions zsh-syntax-highlighting zsh-completions)

alias vim="nvim"
alias vi="nvim"
alias tmux="tmux -2u"
source $ZSH/oh-my-zsh.sh
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_last"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs status)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_STATUS_OK=false
POWERLEVEL9K_STATUS_CROSS=true

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
