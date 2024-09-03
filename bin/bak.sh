#!/bin/bash

# Define el punto de montaje del disco externo
DRIVE="/media/rogrp/ADATA-HD710-PRO"

# Define el nombre del archivo de respaldo
BACKUP_FILE="$DRIVE/f15-ubuntu-bak.tar.gz"

# Define los directorios a excluir en una variable
EXCLUDES="--exclude=/dev \
          --exclude=/mnt \
          --exclude=/proc \
          --exclude=/sys \
          --exclude=/tmp \
          --exclude=/media \
          --exclude=/lost+found \
          --exclude=/run \
          --exclude=/swapfile"

# Verifica si el disco está montado
if [ ! -d "$DRIVE" ]; then
    echo "Error: $DRIVE is not mounted."
    exit 1
fi

# Ejecuta tar para crear el respaldo y mostrar el progreso con pv
sudo tar cf - $EXCLUDES / | \
    pv -pterb -s $(sudo du -sb / $EXCLUDES | awk '{print $1}') | \
    gzip > "$BACKUP_FILE"

echo "Backup completed: $BACKUP_FILE"
