#!/bin/bash

# Take a screenshot
scrot /tmp/screen.png

# Blur the screenshot
convert /tmp/screen.png -blur 0x8 /tmp/screen-blurred.png

# Lock the screen with the blurred image
i3lock -i /tmp/screen-blurred.png

# Optionally, remove the temporary images after locking
rm /tmp/screen.png /tmp/screen-blurred.png
