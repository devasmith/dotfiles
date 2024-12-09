#!/bin/bash

# Define the screenshot and blurred image file paths
SCREENSHOT="/tmp/screenshot.png"
BLURRED_IMAGE="/tmp/blurred_screenshot.png"

# Take a screenshot
grim "$SCREENSHOT"

# Blur the screenshot
convert "$SCREENSHOT" -blur 0x8 "$BLURRED_IMAGE"

# Lock the screen with the blurred image
swaylock -i "$BLURRED_IMAGE" \
         --indicator-caps-lock \
         --indicator-radius 100 \
         --indicator-thickness 7

# Clean up the temporary files
rm "$SCREENSHOT" "$BLURRED_IMAGE"
