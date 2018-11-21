#!/bin/bash

if ! hash playerctl; then
  echo "playerctl not found"
  exit 0
fi

STATUS=$(playerctl status 2> /dev/null)
ARTIST=$(playerctl metadata xesam:artist 2> /dev/null)
TITLE=$(playerctl metadata xesam:title 2> /dev/null)

echo "%{F#FFF}[$STATUS] $ARTIST - $TITLE%{F- B- -o}"
