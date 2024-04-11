# [rogrp]: open tmux as default if tmux is installed
# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#     exec tmux
# fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ================== [copy from .bashrc] =====================

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ================== [added by rogrp] ========================

export TERM=xterm-256color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#757575'

export PATH=$PATH:/usr/local/go/bin
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin
export PATH="$PATH:/home/rogrp/.local/share/JetBrains/Toolbox/scripts"
export PATH="$PATH:/home/rogrp/Personal/bin"
export PATH="$PATH:~/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export gdp=~/Personal/GDP
export stk=~/Personal/Softtek

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/rogrp/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/rogrp/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/rogrp/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/rogrp/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Shift selection
# https://stackoverflow.com/questions/5407916/zsh-zle-shift-selection
# Problems: causa que al presionar la flecha a la derecha el autocompletion no funcione

alias meld="flatpak run org.gnome.meld"

[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh

IS_WSL=$(~/bin/iswsl.sh)

if [ "$IS_WSL" -eq 1 ]; then
    export BROWSER=/usr/bin/wslview
fi
