#!/bin/bash

if ! hash playerctl; then
  echo "playerctl not found"
  exit 0
fi

STATUS=$(playerctl status 2> /dev/null)
RC=$?
if [[ $RC -eq 1 ]]; then
  echo -n "Media player not available"
  exit
fi

ARTIST=$(playerctl metadata xesam:artist 2> /dev/null)
TITLE=$(playerctl metadata xesam:title 2> /dev/null)

echo -n "%{F#FFF}[$STATUS] $ARTIST - $TITLE%{F- B- -o}"
