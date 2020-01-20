#!/bin/bash

sudo borg create -v --progress --stats \
  --exclude $HOME/.cache \
  --exclude $HOME/.gem \
  --exclude $HOME/.rustup \
  --exclude $HOME/.zgen \
  --exclude $HOME/Downloads \
  /mnt/backups/archy::$(date +%d-%m-%Y_%H:%M:%S) \
  /etc $HOME

