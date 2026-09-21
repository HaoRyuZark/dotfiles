#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

wallpaper=$(find "$WALLPAPER_DIR" -type f \
    \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) |
    shuf -n 1)

pkill swaybg

swaybg -i "$wallpaper" -m fill &
