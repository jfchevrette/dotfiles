#!/bin/bash

# Check if homebrew is installed, otherwise install it
if ! which brew 2>/dev/null 1>/dev/null; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install Homebrew apps and Cask apps
brew bundle
