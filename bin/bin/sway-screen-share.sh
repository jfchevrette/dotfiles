#!/usr/bin/env bash

CACHEDIR=~/.cache/sway-screen-share
STATEFILE=$CACHEDIR/state

if ! [[ -d $CACHEDIR ]]; then
    mkdir -p $CACHEDIR
fi

# Check v4l2loopback is loaded
if ! lsmod | grep v4l2loopback > /dev/null; then
    echo >&2 "ERROR v42loopback is not loaded!"
    exit 1
fi

# Check required commands are available
for cmd in ffplay notify-send pgrep pkill slurp swaymsg wf-recorder; do
    hash "${cmd}" 2>/dev/null || { echo >&2 "Command ${cmd} is not available.  Aborting."; exit 1; }
done

if [[ "$1" == "stop" ]]; then
    if pgrep ffplay > /dev/null; then
        pkill ffplay > /dev/null
    fi
    if pgrep wf-recorder > /dev/null; then
        pkill wf-recorder > /dev/null
    fi
    notify-send -t 2000 "Sway recording has been stopped"
    echo > $STATEFILE
elif [[ "$1" == "is-recording" ]]; then
    if pgrep wf-recorder > /dev/null && pgrep ffplay > /dev/null; then
        notify-send -t 2000 "Sway recording is up"
    else
        notify-send -t 2000 "No Sway recording"
    fi
else
    if ! pgrep wf-recorder > /dev/null; then
        windowGeometries=$(
            swaymsg -t get_workspaces -r | jq -r '.[] | select(.focused) | .rect | "\(.x),\(.y) \(.width)x\(.height)"'; \
            swaymsg -t get_outputs -r | jq -r '.[] | select(.active) | .rect | "\(.x),\(.y) \(.width)x\(.height)"'
        )
        geometry=$(slurp -b "#45858820" -c "#45858880" -w 3 -d <<< "$windowGeometries") || exit $?

        wf-recorder --muxer=v4l2 --codec=rawvideo --file=/dev/video4 --geometry="$geometry" &
    fi
    if ! pgrep ffplay; then
        ffplay /dev/video4 &
        sleep 0.5
        # a hack so FPS is not dropping
        swaymsg [class=ffplay] move position 1915 1050
        swaymsg focus tiling
    fi
    notify-send -t 2000 "Sway recording has been started"
    echo "Recording" > $STATEFILE
fi
