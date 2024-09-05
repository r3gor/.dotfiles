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

# ==== NVM auto load .nvmrc ====
# place this after nvm initialization!
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc
# ==== NVM auto load .nvmrc ====

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

# [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
# [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh

IS_WSL=$(~/bin/iswsl.sh)

if [ "$IS_WSL" -eq 1 ]; then
  export BROWSER=/usr/bin/wslview
fi


alias nvim="PATH='~/.nvm/versions/node/v18.19.0/bin:$PATH' /usr/local/bin/nvim"

ZVM_INIT_MODE=sourcing # fix other key-bindings (fzf for example) without it, fzf completion not working (foobar/**)
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
  command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
  command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
    print -P "%F{33} %F{34}Installation successful.%f%b" || \
    print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
#


zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
# zinit light kutsan/zsh-system-clipboard

# fix yank
# https://github.com/jeffreytse/zsh-vi-mode/issues/19
zvm_vi_yank () {
  zvm_yank
  printf %s "${CUTBUFFER}" | xclip -sel c
  zvm_exit_visual_mode
}

export ZVM_VI_EDITOR=nvim
export ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM

# if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
#     alias nvim=nvr -cc split --remote-wait +'set bufhidden=wipe'
# fi
#
# if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
#     export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
#     export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
# else
#     export VISUAL="nvim"
#     export EDITOR="nvim"
# fi



# FZF
# export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*" --glob "!/UserProfile/*"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_CTRL_T_OPTS="
--walker-skip .git,node_modules,target,UserProfile
--preview 'batcat -n --color=always {}'
--bind 'ctrl-/:change-preview-window(down|hidden|)'
"

export FZF_ALT_C_COMMAND="fdfind \
--type directory \
--type symlink \
--follow \
--hidden \
--exclude node_modules \
--exclude .git \
--exclude .idea \
--exclude .node-gyp \
--exclude 'go/pkg/**' \
--exclude 'go/bin/**' \
--exclude 'snap/**' \
--exclude 'anaconda3/**' \
--exclude '.vscode/**' \
--exclude '.cache/**' \
--exclude '.npm/**' \
--exclude '.gitkraken/**' \
--exclude '.config/google-chrome/**' \
--exclude '.config/JetBrains/**' \
"

export FZF_ALT_C_OPTS="
--walker file,follow,hidden
--walker-skip .git,node_modules,target,UserProfile
--preview 'tree -L 1 -C {}'
"

export LS_COLORS="ln=01;30;43" # Esto cambiará los enlaces simbólicos a un color cian.

# fzf command

function xcd_v0=() {
  WORKDIR="${HOME}/xtrimac"
  # Encuentra todas las carpetas y crea la lista de rutas completas
  local folders=$(find $WORKDIR/dev $WORKDIR/dev/be -maxdepth 1 -mindepth 1 -type d)

  # Genera una lista de rutas con su porción única
  local unique_folders=$(echo "$folders" | awk -F'/' '{
    count[$NF]++;
    paths[$NF"/"$0]=$0;
  } END {
    for (path in paths) {
      split(path, arr, "/");
      if (count[arr[1]] > 1) {
        print paths[path];
      } else {
        print substr(paths[path], index(paths[path], arr[1]));
      }
    }
  }' | sed "s|^$WORKDIR/||" | sort -u)

  # Selecciona la carpeta a partir de la lista procesada
  local selected_folder=$(echo "$unique_folders" | fzf --height 40% --border --ansi --prompt="Select a folder: ")

  # Si se selecciona una carpeta, cambiar a la ruta completa correspondiente
  if [ -n "$selected_folder" ]; then
    cd "$WORKDIR/$selected_folder"
  else
    echo "No folder selected."
  fi
}

function xcd() {
  WORKDIR="${HOME}/xtrimac"
  # Encuentra todas las carpetas y crea la lista de rutas completas
  local folders=$(find $WORKDIR/dev $WORKDIR/dev/be -maxdepth 1 -mindepth 1 -type d)

  # Genera una lista de rutas mostrando todo menos el WORKDIR
  local unique_folders=$(echo "$folders" | awk -v workdir="$WORKDIR" -F'/' '{
    sub(workdir "/", "", $0);
    count[$NF]++;
    paths[$0]=$0;
  } END {
    for (path in paths) {
      split(path, arr, "/");
      if (count[arr[1]] > 1) {
        print paths[path];
      } else {
        print path;
      }
    }
  }' | sort -u)

  # Selecciona la carpeta a partir de la lista procesada
  local selected_folder=$(echo "$unique_folders" | fzf --height 40% --border --ansi --prompt="Select a folder: ")

  # Si se selecciona una carpeta, cambiar a la ruta completa correspondiente
  if [ -n "$selected_folder" ]; then
    cd "$WORKDIR/$selected_folder"
  else
    echo "No folder selected."
  fi
}

function fzf_cd_from_home() {
  local FZF_ALT_H_COMMAND="${FZF_ALT_C_COMMAND} . ~"
  local dir
  dir=$(eval $FZF_ALT_H_COMMAND | sed "s|^$HOME|~|" | fzf --preview 'tree -C {}')
  dir="${dir/#\~/$HOME}"
  cd "$dir"
}

bindkey -s '^[d' 'fzf_cd_from_home\n'

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no




# TODO: IMPROVE ORGANIZATION OF THIS SCRIPT !!!!
