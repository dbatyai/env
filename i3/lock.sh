#!/bin/sh -e

# Take a screenshot
scrot -o /tmp/screen_locked.png

# Turn screen off
xset dpms force off

# Blur it
convert /tmp/screen_locked.png -blur 0x6 /tmp/screen_locked.png

# Lock screen displaying this image.
i3lock -i /tmp/screen_locked.png
