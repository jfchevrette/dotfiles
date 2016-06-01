#!/bin/bash

BREWAPPS="
android-platform-tools
ansible
bash
bash-completion
chruby
coreutils
curl
docker
docker-compose
docker-machine
docker-swarm
fzf
git
go
grc
jq
keybase
lua
luajit
mtr
ncftp
nmap
pstree
python
python3
ruby-install
siege
ssh-copy-id
stow
terraform
the_silver_searcher
tig
tmux
zsh
"

CASKAPPS="
alfred
atom
brogue
dungeon-crawl-stone-soup-console
dungeon-crawl-stone-soup-tiles
emacs
google-chrome
hammerspoon
ngrok
slack
steam
vagrant
"

# Check if homebrew is installed, otherwise install it
if ! which brew 2>/dev/null 1>/dev/null; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install Homebrew apps and Cask apps
brew install $BREWAPPS 2> /dev/null
brew cask install $CASKAPPS 2> /dev/null

# Install fonts
brew tap caskroom/fonts
brew cask install font-source-code-pro font-sauce-code-powerline
