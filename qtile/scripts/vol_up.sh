#!/bin/bash

pactl set-sink-volume @DEFAULT_SINK@ +5%

volume=$(pactl get-sink-volume 0 | awk -F'/' '{print $2}' | awk '{print $1}')
dunstify -r 420 "  $volume"
