#!/bin/bash
# ~/.config/recorder/status.sh

if pidof gpu-screen-recorder > /dev/null; then
    echo '{"text": "", "class": "recording", "tooltip": "Recording"}'
else
    echo '{"text": "", "class": "idle", "tooltip": "Idle"}'
fi
