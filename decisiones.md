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

### Out of bounds: (dot)cuore in the home folder (updated 2026-10-05)
- **Decision**: Off limits from any session not started inside it; a session started inside it may use it (under that repo's own rules). Enforced by the PreToolUse hook `hooks/cuore-guard.sh`: it blocks any tool call that mentions the name unless `CLAUDE_PROJECT_DIR` is that folder. `config/setup.sh` adds the hook to `~/.claude/settings.json` and checks it on every session. Outside it, write the name as "(dot)cuore".
- **Reason**: Vicente's personal repo, moved from ~/Workspace/_my_/ on 2026-10-04. The first mechanism was deny rules in settings.json (Read, Bash ls, Bash find). 32278fd replaced them because a deny rule can't be lifted per project, so it also blocked sessions started inside the folder.
- **What would reopen it**: Nothing for the boundary, which is a hard line. The mechanism changes only if the hook turns out not to block.
- **Verified 2026-10-05**: from a session in `~/Workspace/finite_state_machine`, a Write with the name in its content was blocked. Side effect: plain-text mentions are blocked too, not only paths (open for Vicente to decide).

### Learning mode
- **Decision**: Mother asks Vicente if he wants context before touching something new to him. Keeps a running pending-topics list in docs/pending-topics.md.
- **Reason**: Vicente specified this in the forge session.
- **What would reopen it**: Vicente says he prefers to ask for context himself.

## 2026-10-05

### Session start: pull, then check and apply local config
- **Decision**: Every session, `hooks/session-start.sh` runs `git pull --ff-only origin master`, then runs `config/setup.sh` (always, not only when `config/version` changes). `setup.sh` checks the local config and applies what can be applied (today: the (dot)cuore PreToolUse guard hook in `~/.claude/settings.json`, via `jq`, with a backup to `settings.json.bak-mother`).
- **Reason**: Vicente's instruction. `~/.claude/settings.json` is per machine and not in this repo; the guard hook (32278fd) was never added on the laptop because `setup.sh` only checked.
- **What would reopen it**: A config step that can't be applied safely by a script — then `setup.sh` reports it instead.

### EASFP_flash_i2c_cpp: no review-guard pre-commit hook (discard)
- **Decision**: The `/ipronics-code-review` skill's pre-commit guard (blocks commits carrying `[Pending]` markers) was not installed in this repo.
- **Reason**: Vicente's choice when asked at the start of the review.
- **What would reopen it**: `[Pending]` markers reach a shared branch such as `feature/linux_flasher`, `develop` or `main`, or Vicente wants the skill applied as designed.

### EASFP_flash_i2c_cpp: review lives on its own branch
- **Decision**: Review markers and reports are committed on `feature/linux_flasher_review` (Vicente created and pushed it, 109200b), not on `feature/linux_flasher`.
- **Reason**: Keep `[Pending]` markers out of the feature branch while still syncing across machines.
- **What would reopen it**: The guard gets installed, or the team agrees markers can live on feature branches.

### EASFP_flash_i2c_cpp: review base `origin/develop`, FTDI class excluded
- **Decision**: Diff against `origin/develop` (merge base = initial commit, so the full project). `i2c_ftdi_class.*` excluded.
- **Reason**: Vicente chose develop. FTDI class is not in the build and was also excluded in the 2026-10-02 manual review.
- **What would reopen it**: The FTDI class is added to `CMakeLists.txt`.
