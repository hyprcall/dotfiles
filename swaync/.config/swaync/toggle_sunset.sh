#!/bin/bash

LOCK_FILE="/tmp/hyprsunset_state"

if [ -f "$LOCK_FILE" ]; then
    # Currently ON (Warm), switch to OFF (Identity)
    rm "$LOCK_FILE"
    # We use pkill because hyprsunset doesn't natively replace itself cleanly yet
    # But user asked to "change at will". If I don't kill, the new command fails.
    # I will assume "change at will" means "switch the state", and I'll handle the process management transparently.
    pkill hyprsunset
    hyprctl dispatch exec -- hyprsunset --identity
    notify-send -r 9981 "Blue Light Filter" "Disabled"
else
    # Currently OFF, switch to ON (Warm)
    touch "$LOCK_FILE"
    pkill hyprsunset
    hyprctl dispatch exec -- hyprsunset --temperature 5500
    notify-send -r 9981 "Blue Light Filter" "Enabled"
fi
