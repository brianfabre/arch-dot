#!/bin/bash

busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateBrightness d -0.05

bright=$(busctl --user introspect rs.wl-gammarelay / rs.wl.gammarelay | awk '/\.Brightness/ {print $4}')
dunstify -r 350 "BRIGHTNESS: $bright"
