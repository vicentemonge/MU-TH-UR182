#!/bin/sh
R="$HOME/Mother"
CLAUDE="$HOME/.claude"

# Sync first: work moves between machines, and the config check below
# must run against the latest setup.sh.
# Explicit remote/branch: don't depend on upstream tracking being configured
if ! timeout 15 git -C "$R" pull --ff-only -q origin master 2>/dev/null; then
  echo "## git pull failed in $R — sync manually before working"
  echo ""
fi

# Commits made here but never pushed are invisible from the other machine
ahead=$(git -C "$R" rev-list --count origin/master..HEAD 2>/dev/null)
if [ -n "$ahead" ] && [ "$ahead" -gt 0 ]; then
  echo "## $ahead local commit(s) in $R not pushed to origin — push before working elsewhere"
  echo ""
fi

# Config check + apply on every session: local config (settings.json) is per
# machine and can drift without any version bump in this repo.
sh "$R/config/setup.sh"
echo ""

# Show last logbook entry
last=$(ls "$R"/bitacora/*.md 2>/dev/null | sort | tail -n 1)
if [ -n "$last" ]; then
  echo "## Last logbook entry ($last)"
  # Print from the last "## " heading (entry start) to end of file
  awk '/^## /{buf=""} {buf=buf $0 "\n"} END{printf "%s", buf}' "$last"
fi

# Warn about uncommitted changes
dirty=$(git -C "$R" status --short 2>/dev/null)
if [ -n "$dirty" ]; then
  echo "## Uncommitted changes in $R — last session did not close with /cierre:"
  echo "$dirty"
fi
