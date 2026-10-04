#!/bin/sh
R="$HOME/Mother"
CLAUDE="$HOME/.claude"
VERSION_FILE="$R/config/version"
INIT_FILE="$CLAUDE/.mother_init"

# Config check: only run if version changed or never checked
CURRENT=$(cat "$VERSION_FILE" 2>/dev/null)
LAST=$(cat "$INIT_FILE" 2>/dev/null)
if [ "$CURRENT" != "$LAST" ]; then
  sh "$R/config/setup.sh"
  echo ""
fi

# Show last logbook entry
last=$(ls "$R"/bitacora/*.md 2>/dev/null | sort | tail -n 1)
if [ -n "$last" ]; then
  echo "## Last logbook entry ($last)"
  tail -n 40 "$last"
fi

# Warn about uncommitted changes
dirty=$(git -C "$R" status --short 2>/dev/null)
if [ -n "$dirty" ]; then
  echo "## Uncommitted changes in $R — last session did not close with /cierre:"
  echo "$dirty"
fi
