#!/bin/sh

# redshift-gtk &

xset r rate 400 50 &

# disables fade animation
# picom --fade-in-step=1 --fade-out-step=1 --fade-delta=0 &

# executed in startx
# xmodmap ~/.Xmodmap &

xrandr --output DP-0 --mode 1920x1080 --rate 165 --output HDMI-0 --left-of DP-0 &
