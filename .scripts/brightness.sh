#!/usr/bin/env sh

echo $(( $(cat /sys/class/backlight/intel_backlight/brightness) + $1 )) > /sys/class/backlight/intel_backlight/brightness
