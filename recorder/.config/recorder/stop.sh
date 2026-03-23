#!/bin/bash
# ~/.config/recorder/stop.sh

# Kill gpu-screen-recorder
killall -SIGINT gpu-screen-recorder

# Wait for process to fully exit
while pidof gpu-screen-recorder >/dev/null; do
    sleep 0.1
done

notify-send -u normal "GPU Screen Recorder" "Recording stopped and buffer discarded."
pkill -RTMIN+10 waybar
