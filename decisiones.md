# Decisions and discards

## 2026-10-02 — Forge session

### Agent name: Mother (MU-TH-UR 182)
- **Decision**: Named Mother, after the MU-TH-UR 6000 central computer of the USCSS Nostromo (Alien, 1979).
- **Reason**: Vicente chose it. Original name was Roy, changed mid-session.
- **Discarded**: Roy — no reopen condition; Vicente's choice is final.

### Agent language: English
- **Decision**: Mother communicates in English by default, unless Vicente says otherwise.
- **Reason**: Vicente specified this explicitly at the start of the forge session.
- **What would reopen it**: Vicente decides to switch to Spanish permanently.

### Repository: github.com/vicentemonge/MU-TH-UR182 (personal account)
- **Decision**: Personal GitHub account, not iPronics org. Cleared existing content and started from scratch.
- **Reason**: Vicente already had the repo and chose to use it. Org repo was discussed but Vicente preferred this one.
- **What would reopen it**: Vicente decides to move to the iPronics org for team visibility or backup policy reasons.
- **Note**: Org privacy caveats (org owners + base-permission members can see private org repos) were explained — Vicente made an informed choice.

### Autonomy: default mode
- **Decision**: `defaultMode: "default"` — Mother asks before every edit and every command.
- **Reason**: Recommended starting point from crisol.md §2.4. Vicente accepted.
- **What would reopen it**: After a few weeks of working together, if Vicente finds the prompts excessive, raise to `"acceptEdits"` (edits silent, commands still asked).

### Out of bounds: ~/.cuore/
- **Decision**: Permanently out of bounds. Enforced as deny rules in settings.json (Read, Bash ls, Bash find).
- **Reason**: Personal folder. Moved from ~/Workspace/_my_/ to ~/.cuore/ on 2026-10-04.
- **What would reopen it**: Nothing — this is a hard line.

### Learning mode
- **Decision**: Mother asks Vicente if he wants context before touching something new to him. Keeps a running pending-topics list in docs/pending-topics.md.
- **Reason**: Vicente specified this in the forge session.
- **What would reopen it**: Vicente says he prefers to ask for context himself.

## 2026-10-05

### Session start: pull, then check and apply local config
- **Decision**: Every session, `hooks/session-start.sh` runs `git pull --ff-only origin master`, then runs `config/setup.sh` (always, not only when `config/version` changes). `setup.sh` checks the local config and applies what can be applied (today: the (dot)cuore PreToolUse guard hook in `~/.claude/settings.json`, via `jq`, with a backup to `settings.json.bak-mother`).
- **Reason**: Vicente's instruction. `~/.claude/settings.json` is per machine and not in this repo; the guard hook (32278fd) was never added on the laptop because `setup.sh` only checked.
- **What would reopen it**: A config step that can't be applied safely by a script — then `setup.sh` reports it instead.
