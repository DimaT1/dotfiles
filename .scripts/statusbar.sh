#!/usr/bin/env sh

brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
battery_state=$(~/.scripts/bat.sh)
ram=$(~/.scripts/ram.sh)
cpu=$(~/.scripts/cpu.sh)
ip=$(nmcli -a | grep 'inet4 192' | awk '{print $2}')
date_time=$(date +"%a %d.%m.%Y %H:%M:%S")

[ "$ip" = "" ] && ip="DOWN"

printf " 💻 %s %s | ⚙ %s | 🌡️ % s | 🌎 %s | %s" "$brightness" "$battery_state" "$ram" "$cpu" "$ip" "$date_time"
