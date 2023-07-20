#!/bin/bash

# volume=$(pactl list sinks | perl -000ne 'if(/#1/){/Volume:.*?(\d+)%/; print "$1%\n"}')
volume=$(pactl get-sink-volume 0 | awk -F'/' '{print $2}' | awk '{print $1}')

pactl set-sink-volume @DEFAULT_SINK@ -5%
dunstify -r 420 "  $volume"
