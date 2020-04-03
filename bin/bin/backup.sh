#!/bin/bash

sudo borg create --umask 0027 -v --progress --stats \
  --exclude $HOME/.cache \
  --exclude $HOME/.gem \
  --exclude $HOME/.local/share/containers \
  --exclude $HOME/.rustup \
  --exclude $HOME/.zgen \
  --exclude $HOME/Downloads \
  /mnt/backups/archy::$(date +%d-%m-%Y_%H:%M:%S) \
  /etc $HOME

sudo borg prune --umask 0027 -v /mnt/backups/archy
  --keep-hourly 24 \
  --keep-daily 7 \
  --keep-weekly 4 \
  --keep-monthly 6
