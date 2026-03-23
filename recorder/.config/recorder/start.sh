#!/bin/bash
# ~/.config/recorder/start.sh

MONITOR=$1
if [ -z "$MONITOR" ]; then
    MONITOR="screen" # fallback
fi

# Create the replays directory if it doesn't exist
mkdir -p ~/Videos/replays

# Start gpu-screen-recorder with a 1 hour (3600 seconds) rolling replay buffer
# Captures default PipeWire sink monitor for audio
gpu-screen-recorder -w "$MONITOR" -f 60 -a "$(pactl get-default-sink).monitor" -r 3600 -c mp4 -o ~/Videos/replays &

if [ "$MONITOR" = "screen" ]; then
    notify-send -u normal "GPU Screen Recorder" "Replay buffer started (All Monitors)."
else
    notify-send -u normal "GPU Screen Recorder" "Replay buffer started on $MONITOR."
fi

pkill -RTMIN+10 waybar
