#!/bin/bash

stow -t $HOME -D stow
stow -t $HOME stow

for dir in */; do
  echo Unstowing $dir
  stow -t $HOME -D $dir
  echo Restowing $dir
  stow -t $HOME $dir
done
