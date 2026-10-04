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
  # Must NOT have .cuore deny rules globally (they belong in project settings)
  if grep -q 'cuore' "$CLAUDE/settings.json"; then
    err "settings.json has .cuore rules globally — should be project-scoped"
  else
    ok "settings.json has no global .cuore deny (correct)"
  fi
else
  err "~/.claude/settings.json does not exist"
fi

# 3. Project-level deny for Mother must block .cuore
PROJECT_SETTINGS="$CLAUDE/projects/-home-vmonge-Mother/settings.json"
if [ -f "$PROJECT_SETTINGS" ]; then
  if grep -q 'cuore' "$PROJECT_SETTINGS"; then
    ok "Mother project settings deny .cuore"
  else
    err "Mother project settings exist but missing .cuore deny"
  fi
else
  err "Mother project settings do not exist ($PROJECT_SETTINGS)"
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
