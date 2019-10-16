#!/bin/bash

awk -F: '{print $1}' index | xargs ./stow.sh
