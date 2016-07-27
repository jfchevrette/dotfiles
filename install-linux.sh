#!/bin/bash

if [[ -f /etc/fedora-release ]]; then
	sudo dnf install -y stow zsh
fi
