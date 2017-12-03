#!/bin/bash


defaults write -g com.apple.swipescrolldirection -bool false

defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 10 

defaults delete com.apple.dock persistent-apps
defaults delete com.apple.dock persistent-others

DOCKAPPS="
/Applications/Google Chrome.app
/Applications/iTerm.app
/Applications/Visual Studio Code.app
/Applications/Mattermost.app
"

IFS=$'\n'
for app in $DOCKAPPS; do
  defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done
unset IFS

killall Dock
osascript -e 'tell app "System Events" to display dialog "Some settings requires Logoff/Login to take effect." buttons "OK" default button 1' > /dev/null 2>&1
