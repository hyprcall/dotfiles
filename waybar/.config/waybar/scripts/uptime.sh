#!/usr/bin/env bash
up=$(awk '{print $1}' /proc/uptime)
mins=$(awk -v u="$up" 'BEGIN{printf "%d", u/60}')
printf " %dh %dm\n" "$((mins/60))" "$((mins%60))"
