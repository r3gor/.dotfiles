#!/bin/bash

backup_and_link() {
  echo ""
  local target="$1"
  local linkname="$2"

  # archivo no existe en ningun lugar
  if [ ! -e "$linkname" ] && [ ! -e "$target" ]; then
    echo "❌  Not found. $linkname, $target"
    return
  fi

  # archivo existe pero no en dotfiles
  if [ -e "$linkname" ] && [ ! -e "$target" ]; then
    # Clonar el archivo de linkname a target
    cp -r "$linkname" "$target"
    echo "⬅️ Copying. $linkname => $target"
  fi

  # archivo existe, se hace backup
  if [ -e "$linkname" ] || [ -L "$linkname" ]; then

    # Si es un enlace simbólico que ya existe
    if [ -L "$linkname" ]; then
      if [ "$(readlink "$linkname")" == "$target" ]; then
        echo "☑️ $linkname"
        return
      fi
    fi


    local backup="$linkname.bak"
    local counter=1

    while [ -e "$backup" ]; do
      backup="$linkname.bak$counter"
      counter=$((counter + 1))
    done

    mv "$linkname" "$backup"
    echo "💾  Backup $linkname => $backup"
  fi

  ln -s "$target" "$linkname"
  echo "✅  $linkname"
}

# Definir la ruta base donde están almacenados los dotfiles
DOTFILES_DIR=~/dotfiles

# Crear enlaces simbólicos para los archivos y directorios
backup_and_link $DOTFILES_DIR/.bashrc ~/.bashrc
backup_and_link $DOTFILES_DIR/.gitconfig ~/.gitconfig
backup_and_link $DOTFILES_DIR/.p10k.zsh ~/.p10k.zsh
backup_and_link $DOTFILES_DIR/.tmux.conf ~/.tmux.conf
backup_and_link $DOTFILES_DIR/.zshrc ~/.zshrc
backup_and_link $DOTFILES_DIR/.config/Code/User/keybindings.json ~/.config/Code/User/keybindings.json
backup_and_link $DOTFILES_DIR/.config/Code/User/settings.json ~/.config/Code/User/settings.json
backup_and_link "$DOTFILES_DIR/bin" ~/bin
backup_and_link "$DOTFILES_DIR/.config/nvim" ~/.config/nvim
backup_and_link "$DOTFILES_DIR/.config/i3" ~/.config/i3
backup_and_link "$DOTFILES_DIR/.config/i3blocks" ~/.config/i3blocks
backup_and_link "$DOTFILES_DIR/.config/kitty" ~/.config/kitty
backup_and_link "$DOTFILES_DIR/.config/tmux-powerline" ~/.config/tmux-powerline
backup_and_link "$DOTFILES_DIR/.config/zathura" ~/.config/zathura
backup_and_link "$DOTFILES_DIR/.config/emacs" ~/.config/emacs
backup_and_link "$DOTFILES_DIR/.config/conky" ~/.config/conky


echo
echo "Done."


