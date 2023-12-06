#!/bin/bash

bright=$(busctl --user introspect rs.wl-gammarelay / rs.wl.gammarelay | awk '/\.Brightness/ {print $4}')

busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateBrightness d -0.05
dunstify -r 350 "BRIGHTNESS: $bright"
