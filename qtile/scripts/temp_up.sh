#!/bin/bash

temp=$(busctl --user introspect rs.wl-gammarelay / rs.wl.gammarelay | awk '/\.Temperature/ {print $4}')

busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n +100
dunstify -r 300 "TEMP: $temp"
