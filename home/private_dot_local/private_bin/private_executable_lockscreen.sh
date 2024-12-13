#!/bin/bash

# Temporary directory for screenshots
TMP_DIR="/tmp/lockscreen"
mkdir -p "$TMP_DIR"

# Capture and blur each active monitor
swaymsg -t get_outputs | jq -r '.[] | select(.active == true) | .name' | while read -r output; do
    SCREENSHOT="$TMP_DIR/${output}.png"
    BLURRED_IMAGE="$TMP_DIR/${output}_blurred.png"

    # Capture screenshot for the output
    grim -o "$output" "$SCREENSHOT"

    # Blur the screenshot
    convert "$SCREENSHOT" -blur 0x8 "$BLURRED_IMAGE"
done

# Build swaylock command with all blurred images
LOCK_CMD="swaylock"
for blurred in "$TMP_DIR"/*_blurred.png; do
    LOCK_CMD+=" -i $blurred"
done

# Add additional swaylock options
$LOCK_CMD --indicator-caps-lock \
          --indicator-radius 100 \
          --indicator-thickness 7

# Clean up the temporary directory
rm -rf "$TMP_DIR"

