#!/bin/bash

busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n +250

temp=$(busctl --user introspect rs.wl-gammarelay / rs.wl.gammarelay | awk '/\.Temperature/ {print $4}')
dunstify -r 300 "TEMP: $temp"
