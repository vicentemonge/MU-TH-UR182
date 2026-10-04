#!/bin/sh
# PreToolUse guard: ~/.cuore is only reachable from sessions started inside it.
input=$(cat)
printf '%s' "$input" | grep -q '\.cuore' || exit 0
case "$CLAUDE_PROJECT_DIR" in
  "$HOME/.cuore"|"$HOME/.cuore/"*) exit 0 ;;
esac
echo "Blocked: ~/.cuore is only accessible from sessions started in ~/.cuore." >&2
exit 2
