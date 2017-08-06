#!/bin/bash

CURRENT="%{F#ffffff B#161616 o#fb2874 +o}"
NORMAL="%{F#FFF}"
OTHERMON="%{F#ffffff B#161616 o#1976d2 +o}"
EMPTY="%{F#555}"
UNSET="%{F- B- -o}"

TAGS=$(herbstclient tag_status | sed 's/\s/\n/g')
for tag in $TAGS; do
    name=${tag:1:2}
    if [[ ${tag:0:1} == '#' ]]; then #current
        echo -n "${CURRENT} $name ${UNSET} "
    elif [[ ${tag:0:1} == '.' ]]; then #empty
        echo -n "${EMPTY} $name ${UNSET} "
    elif [[ ${tag:0:1} == '-' ]]; then #other monitor
        echo -n "${OTHERMON} $name ${UNSET} "
    else #not empty
        echo -n "${NORMAL} $name ${UNSET} "
    fi
done
