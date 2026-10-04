#!/bin/sh
# Mother system configuration check/apply
# Called by session-start.sh when config version changes.
# Exit 0 = all good, non-zero = something failed.

set -e

MOTHER="$HOME/Mother"
CLAUDE="$HOME/.claude"
VERSION_FILE="$MOTHER/config/version"
INIT_FILE="$CLAUDE/.mother_init"
ERRORS=""

err() { ERRORS="$ERRORS\n- $1"; }
ok()  { echo "  [ok] $1"; }

echo "## Mother config check (v$(cat "$VERSION_FILE"))"

# 1. ~/.claude/CLAUDE.md must exist and import Mother.md
if [ -f "$CLAUDE/CLAUDE.md" ]; then
  if grep -qx '@~/Mother/Mother.md' "$CLAUDE/CLAUDE.md"; then
    ok "CLAUDE.md imports Mother.md"
  else
    err "CLAUDE.md exists but does not import Mother.md"
  fi
else
  err "~/.claude/CLAUDE.md does not exist"
fi

# 2. ~/.claude/settings.json must have SessionStart hook
if [ -f "$CLAUDE/settings.json" ]; then
  if grep -q 'session-start.sh' "$CLAUDE/settings.json"; then
    ok "settings.json has session-start hook"
  else
    err "settings.json missing session-start hook"
  fi
  # 3. .cuore deny must be global — user settings are the only file that
  # applies in every project (~/.claude/projects/*/settings.json is never read)
  if grep -q '"Read(~/.cuore/\*\*)"' "$CLAUDE/settings.json"; then
    ok "settings.json denies Read on ~/.cuore"
  else
    err "settings.json missing Read(~/.cuore/**) deny"
  fi
else
  err "~/.claude/settings.json does not exist"
fi

# 4. cierre skill symlink
if [ -L "$CLAUDE/skills/cierre" ]; then
  ok "cierre skill symlinked"
else
  err "cierre skill symlink missing (~/.claude/skills/cierre)"
fi

# Report
if [ -n "$ERRORS" ]; then
  echo ""
  echo "## Config problems found — fix before continuing:"
  printf "$ERRORS\n"
  exit 1
else
  # Write version to init file
  cp "$VERSION_FILE" "$INIT_FILE"
  echo "  All checks passed."
fi
