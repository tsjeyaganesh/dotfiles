#!/bin/bash

CPU="$(top -l 1 | grep "CPU usage" | awk '{print $3}' | cut -d. -f1)"
sketchybar --set $NAME label="${CPU}%"
