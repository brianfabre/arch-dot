#!/bin/bash

channel=$(rofi -dmenu -p Twitch)

streamlink twitch.tv/$channel best --twitch-disable-ads --player=mpv --twitch-low-latency
