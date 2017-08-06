#!/bin/bash

while read -r hook; do
    echo $hook | grep ^tag_changed &&
        polybar-msg hook herbstluftwm 1
done < <(herbstclient -i)
