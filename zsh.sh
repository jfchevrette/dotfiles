#!/bin/bash

# Install oh-my-zsh if not already present
if ! [[ -d ~/.oh-my-zsh ]]; then
	git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
	curl -sL https://raw.githubusercontent.com/dracula/zsh/master/dracula.zsh-theme -o ~/.oh-my-zsh/themes/dracula.zsh-theme
fi

# Change shell
if [[ -f /etc/fedora-release ]]; then
	chsh -s /usr/bin/zsh
else
	chsh -s /usr/local/bin/zsh
fi
