#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi

read -sp 'Borg passphrase: ' BORG_PASSPHRASE
export BORG_PASSPHRASE

echo "Creating backup"
borg create --umask 0027 -v --progress --stats \
  --exclude $HOME/.cache \
  --exclude $HOME/.gem \
  --exclude $HOME/.local/share/containers \
  --exclude $HOME/.rustup \
  --exclude $HOME/.zgen \
  --exclude $HOME/Downloads \
  /mnt/backups/archy::$(date +%d-%m-%Y_%H:%M:%S) \
  /etc $HOME

echo "Pruning backups"
borg prune --umask 0027 -v /mnt/backups/archy \
  --keep-hourly 24 \
  --keep-daily 7 \
  --keep-weekly 4 \
  --keep-monthly 6
