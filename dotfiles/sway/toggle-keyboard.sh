#!/bin/bash

STATE_FILE="/tmp/sway-keyboard-state"

# Default to corne if no state file exists
if [[ ! -f "$STATE_FILE" ]]; then
    echo "corne" > "$STATE_FILE"
fi

CURRENT=$(cat "$STATE_FILE")

if [[ "$CURRENT" == "corne" ]]; then
    # Switch to laptop keyboard (dvorak programmer's variant with modifier swaps)
    swaymsg 'input type:keyboard xkb_layout "pl,es"'
    swaymsg 'input type:keyboard xkb_variant "dvp,dvorak"'
    swaymsg 'input type:keyboard xkb_options "ctrl:swap_lalt_lctl_lwin,grp:alt_space_toggle"'
    echo "laptop" > "$STATE_FILE"
    notify-send -t 2000 "Keyboard" "Switched to Laptop (dvp)"
else
    # Switch to corne keyboard (standard layout, dvorak in firmware)
    swaymsg 'input type:keyboard xkb_layout "us,es"'
    swaymsg 'input type:keyboard xkb_variant ""'
    swaymsg 'input type:keyboard xkb_options ""'
    echo "corne" > "$STATE_FILE"
    notify-send -t 2000 "Keyboard" "Switched to Corne (us)"
fi
