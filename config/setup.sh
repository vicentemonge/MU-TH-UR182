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
if grep -qx '@~/Mother/INDEX.md' "$MOTHER/Mother.md"; then
  ok "Mother.md imports INDEX.md"
else
  err "Mother.md does not import INDEX.md (@~/Mother/INDEX.md)"
fi

# 2. ~/.claude/settings.json must have SessionStart hook
if [ -f "$CLAUDE/settings.json" ]; then
  if grep -q 'session-start.sh' "$CLAUDE/settings.json"; then
    ok "settings.json has session-start hook"
  else
    err "settings.json missing session-start hook"
  fi
  # 3. ~/.cuore guard: a PreToolUse hook in user settings (the only file that
  # applies in every project). No deny rules: a deny can't be lifted per project,
  # so it would also block sessions started inside ~/.cuore.
  # settings.json is per machine (not in this repo): apply the hook if missing.
  if ! grep -q 'cuore-guard.sh' "$CLAUDE/settings.json"; then
    cp "$CLAUDE/settings.json" "$CLAUDE/settings.json.bak-mother"
    if jq '.hooks.PreToolUse = ((.hooks.PreToolUse // []) + [{"hooks":[{"type":"command","command":"sh $HOME/Mother/hooks/cuore-guard.sh"}]}])' \
         "$CLAUDE/settings.json" > "$CLAUDE/settings.json.tmp-mother"; then
      mv "$CLAUDE/settings.json.tmp-mother" "$CLAUDE/settings.json"
      echo "  [applied] added cuore-guard PreToolUse hook to settings.json (backup: settings.json.bak-mother) — active from the next session"
    else
      rm -f "$CLAUDE/settings.json.tmp-mother"
    fi
  fi
  if grep -q 'cuore-guard.sh' "$CLAUDE/settings.json" && [ -f "$MOTHER/hooks/cuore-guard.sh" ]; then
    ok "settings.json has cuore-guard PreToolUse hook"
  else
    err "settings.json missing PreToolUse hook: sh ~/Mother/hooks/cuore-guard.sh"
  fi
  if grep -q '~/.cuore' "$CLAUDE/settings.json"; then
    err "settings.json still has ~/.cuore deny rules — remove them (they block sessions inside ~/.cuore)"
  else
    ok "settings.json has no ~/.cuore deny rules"
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
