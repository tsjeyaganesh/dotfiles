#!/bin/bash

# Highlight the focused workspace
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.drawing=on background.color=$ACCENT_COLOR icon.color=0xff1e1e2e
else
  sketchybar --set $NAME background.drawing=off icon.color=$TEXT_COLOR
fi
