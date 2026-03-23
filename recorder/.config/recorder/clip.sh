#!/bin/bash
# ~/.config/recorder/clip.sh

DURATION=$1
if [ -z "$DURATION" ]; then
    DURATION=60
fi

# Send SIGUSR1 to flush the replay buffer and save the file
killall -SIGUSR1 gpu-screen-recorder

# Wait for the file to be saved (gpu-screen-recorder takes a moment to write)
sleep 2

mkdir -p "$HOME/Videos/screen recording"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
OUT_FILE="$HOME/Videos/screen recording"/clip_${DURATION}s_${TIMESTAMP}.mp4

# Find the most recently created replay file
LATEST_REPLAY=$(ls -t ~/Videos/replays/*.mp4 2>/dev/null | head -n 1)

if [ -n "$LATEST_REPLAY" ]; then
    # Trim the last DURATION seconds and save to clips
    # -sseof -$DURATION seeks to DURATION seconds before the end of the file
    ffmpeg -y -sseof -$DURATION -i "$LATEST_REPLAY" -c copy "$OUT_FILE"
    
    notify-send -u normal "GPU Screen Recorder" "Saved clip: clip_${DURATION}s_${TIMESTAMP}.mp4"
else
    notify-send -u critical "GPU Screen Recorder" "Failed to find replay file to clip."
fi
pkill -RTMIN+10 waybar
