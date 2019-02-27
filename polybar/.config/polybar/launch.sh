#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep .5; done

# Launch polybar
PRI=$(xrandr --query | grep "connected primary" | cut -d\  -f1)
MONITOR=$PRI polybar main -r -c "/home/${USER}/.config/polybar/config" &

# Launch polybar on all monitors
#xrandr --query | grep " connected" | cut -d\  -f1 | while read -r monitor; do
#    MONITOR=$monitor polybar main -c "/home/${USER}/.config/polybar/config" &
#done
