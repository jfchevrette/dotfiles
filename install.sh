#!/bin/bash

OS_TYPE=$(uname -o)

if [[ "$OS_TYPE" == "GNU/Linux" ]]; then
	./install-linux.sh
elif [[ "$OS_TYPE" == "Darwin" ]]; then
	./install-osx.sh
fi
