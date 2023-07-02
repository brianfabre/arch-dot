#!/bin/sh

redshift-gtk &
xset r rate 400 50 &
# disables fade animation
picom --fade-in-step=1 --fade-out-step=1 --fade-delta=0 &
# xmodmap ~/.Xmodmap &
