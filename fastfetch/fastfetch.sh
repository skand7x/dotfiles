#!/bin/bash

CONFIG="$HOME/.config/fastfetch/config.jsonc"

HYPRLOCK="$HOME/.config/hypr/hyprlock.conf"

LOGODIR="$HOME/.config/fastfetch/flogos/"

randint=$(((RANDOM % 16) + 1))

randlogo="$randint.icon"

LOGO="$LOGODIR$randlogo"

sed -i -E "s|(\"source\"\s*:\s*\").*?(\")|\1$LOGO\2|" "$CONFIG"

sed -i "/^\s*image\s*{/,/^\s*}/{s|^\s*path\s*=.*|    path = $LOGO|}" "$HYPRLOCK"

fastfetch
