#!/bin/bash
set -e
scrot -s "$HOME/Pictures/Screenshots/Screenshot_%Y-%m-%d_%H.%M.%S.png" -e 'xclip -selection clipboard -t image/png -i $f'
notify-send --icon=gtk-info Scrot "Screenshot copied to clipboard"
