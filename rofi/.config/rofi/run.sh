#!/bin/sh
 
TMP=`mktemp -u`

RESOLUTION=$(xrandr | grep connected\ primary | awk '{print $4}')
RES=$(echo $RESOLUTION | cut -d+ -f1)
OFFSET=$(echo $RESOLUTION | cut -d+ -f2,3)
 
ffmpeg \
  -video_size $RES \
  -f x11grab -i :0.0+$OFFSET \
  -vf avgblur=10:15:10 \
  -vframes 1 \
  -f image2pipe -vcodec png \
  -preset ultrafast \
$TMP > /dev/null
 
feh -F $TMP &
PID=$!
 
sleep .1
rofi -modi combi -show combi -combi-modi drun,run
 
kill $PID
rm $TMP
