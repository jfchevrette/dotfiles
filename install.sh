#!/bin/bash

OS_TYPE=$(uname -o)

if [[ "$OS_TYPE" == "GNU/Linux" ]]; then
	./install-linux.sh
elif [[ "$OS_TYPE" == "Darwin" ]]; then
	./install-osx.sh
fi

awk -F: '{print $1}' index | xargs ./stow.sh
