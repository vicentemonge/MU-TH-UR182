# Claude Code config — how Mother is wired, and what is broken

_Last updated 2026-10-04_

## How Mother is supposed to load
1. `~/.claude/CLAUDE.md` imports `~/Mother/Mother.md` (global instructions, every session).
2. `~/.claude/settings.json` registers a session-start hook → `~/Mother/hooks/session-start.sh`.
3. The hook runs `config/setup.sh` when `config/version` ≠ `~/.claude/.mother_init`,
   shows the last logbook entry, and warns about uncommitted changes.
4. `~/.claude/skills/cierre` → symlink to `~/Mother/skills/cierre`.

## What we learned
- **Hook event names are a fixed list.** `PostConversationStart` does not exist; Claude Code
  ignores unknown events silently except for a settings warning. The event for "session opens"
  is `SessionStart` (matchers: `startup`, `resume`, `clear`, `compact`; none = all).
  Source: Claude Code settings warning listing valid events (2026-10-04 session).
- **CLAUDE.md import syntax is `@path`**, e.g. `@~/Mother/Mother.md` — not `@import path`.
  Source: Claude Code memory docs; observed: with `@import`, Mother.md content was absent from
  context in the 2026-10-04 session. Fix not yet tested.
- **`setup.sh` checks must test for the correct state**, not the current one. It currently
  greps for `@import ~/Mother/Mother.md`, so it approves the broken import.
- **Project settings location (unverified):** Claude Code reads settings from
  `~/.claude/settings.json`, `<project>/.claude/settings.json` and
  `<project>/.claude/settings.local.json`. `~/.claude/projects/<slug>/` holds transcripts and
  memory; I believe a `settings.json` there is not read. If so, the `.cuore` deny rules in
  `~/.claude/projects/-home-vmonge-Mother/settings.json` do nothing. Verify with `/permissions`
  from a session in `~/Mother`.

## Fixes pending (need Vicente's OK — global config)
1. `settings.json`: `PostConversationStart` → `SessionStart` (matcher: TBD).
2. `CLAUDE.md`: `@import ~/Mother/Mother.md` → `@~/Mother/Mother.md`.
3. `config/setup.sh`: check 1 grep → `@~/Mother/Mother.md`; check 2 → also require `SessionStart`;
   bump `config/version` so it re-runs.
4. `.cuore` deny: move rules to a location Claude Code actually reads (decide where — global
   conflicts with setup.sh's "must be project-scoped" check).
