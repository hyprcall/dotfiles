#!/bin/bash
# ~/.config/recorder/menu.sh

THEME="$HOME/.config/rofi/recorder.rasi"

if pidof gpu-screen-recorder > /dev/null; then
    # Recording active
    CHOICE=$(echo -e "Clip last 1 min\nClip last 5 mins\nClip last 30 mins\nClip last 1 hour\nStop & Discard" | rofi -dmenu -theme "$THEME" -p "Recorder")
    case "$CHOICE" in
        "Clip last 1 min") ~/.config/recorder/clip.sh 60 ;;
        "Clip last 5 mins") ~/.config/recorder/clip.sh 300 ;;
        "Clip last 30 mins") ~/.config/recorder/clip.sh 1800 ;;
        "Clip last 1 hour") ~/.config/recorder/clip.sh 3600 ;;
        "Stop & Discard") ~/.config/recorder/stop.sh ;;
    esac
else
    # Not recording
    MONITORS=$(gpu-screen-recorder --list-monitors | awk -F'|' '{print "Start Recording ("$1")"}')
    CHOICES="$MONITORS\nStart Recording (All Monitors)\nCancel"
    
    CHOICE=$(echo -e "$CHOICES" | rofi -dmenu -theme "$THEME" -p "Recorder")
    
    if [[ "$CHOICE" == "Start Recording ("*")" ]]; then
        # Extract monitor name
        MONITOR=$(echo "$CHOICE" | sed 's/Start Recording (\(.*\))/\1/')
        ~/.config/recorder/start.sh "$MONITOR"
    elif [[ "$CHOICE" == "Start Recording (All Monitors)" ]]; then
        ~/.config/recorder/start.sh "screen"
    fi
fi
