#!/bin/bash

backup_and_link() {
    local target="$1"
    local linkname="$2"

    # Si el directorio o archivo de destino ya existe
    if [ -e "$linkname" ]; then
        local backup="$linkname.bak"
        local counter=1

        # Incrementa el número si el archivo .bak ya existe
        while [ -e "$backup" ]; do
            backup="$linkname.bak$counter"
            counter=$((counter + 1))
        done

        # Renombra el archivo o directorio existente
        mv "$linkname" "$backup"
        echo "Backup $linkname -> $backup"
    fi

    # Crear el enlace simbólico
    ln -s "$target" "$linkname"
}

# Definir la ruta base donde están almacenados los dotfiles
DOTFILES_DIR=~/dotfiles

# Crear enlaces simbólicos para los archivos y directorios
ln -sf $DOTFILES_DIR/.bashrc ~/.bashrc
ln -sf $DOTFILES_DIR/.gitconfig ~/.gitconfig
ln -sf $DOTFILES_DIR/.p10k.zsh ~/.p10k.zsh
ln -sf $DOTFILES_DIR/.tmux.conf ~/.tmux.conf
ln -sf $DOTFILES_DIR/.zshrc ~/.zshrc
ln -sf $DOTFILES_DIR/.config/Code/User/keybindings.json ~/.config/Code/User/keybindings.json
ln -sf $DOTFILES_DIR/.config/Code/User/settings.json ~/.config/Code/User/settings.json
backup_and_link "$DOTFILES_DIR/bin" ~/bin
backup_and_link "$DOTFILES_DIR/.config/nvim" ~/.config/nvim

echo "Symbolic links created successfully"
