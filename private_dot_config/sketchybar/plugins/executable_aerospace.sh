#!/bin/bash

ACCENT_COLOR=0xff89b4fa
TEXT_COLOR=0xffcdd6f4

# Get focused workspace from aerospace if not provided by event
if [ -z "$FOCUSED_WORKSPACE" ]; then
  FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused 2>/dev/null)
fi

# Check if this workspace has any windows
WINDOWS=$(aerospace list-windows --workspace "$1" 2>/dev/null | wc -l | tr -d ' ')
IS_FOCUSED=$( [ "$1" = "$FOCUSED_WORKSPACE" ] && echo "true" || echo "false" )

if [ "$IS_FOCUSED" = "true" ]; then
  sketchybar --set "$NAME" drawing=on background.drawing=on background.color="$ACCENT_COLOR" icon.color=0xff1e1e2e
elif [ "$WINDOWS" -gt 0 ]; then
  sketchybar --set "$NAME" drawing=on background.drawing=off icon.color="$TEXT_COLOR"
else
  sketchybar --set "$NAME" drawing=off
fi
