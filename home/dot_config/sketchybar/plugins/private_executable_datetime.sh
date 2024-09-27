#!/bin/zsh

export LC_ALL=en_US.UTF-8
sketchybar --set $NAME label="$(date '+%a. %e %B %H:%M' | tr A-Z a-z)"
