#!/bin/bash

# volume=$(pactl list sinks | perl -000ne 'if(/#1/){/Volume:.*?(\d+)%/; print "$1%\n"}')
volume=$(pactl get-sink-volume 0 | awk -F'/' '{print $2}' | awk '{print $1}')

pactl set-source-mute @DEFAULT_AUDIO_SINK@ toggle
dunstify -r 420 "  $volume"
