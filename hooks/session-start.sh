#!/bin/sh
R="$HOME/Mother"
last=$(ls "$R"/bitacora/*.md 2>/dev/null | sort | tail -n 1)
if [ -n "$last" ]; then
  echo "## Last logbook entry ($last)"
  tail -n 40 "$last"
fi
dirty=$(git -C "$R" status --short 2>/dev/null)
if [ -n "$dirty" ]; then
  echo "## Uncommitted changes in $R — last session did not close with /cierre:"
  echo "$dirty"
fi
