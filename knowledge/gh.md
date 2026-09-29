# GitHub CLI (`gh`) — Reference

Concise command reference built up session by session. Commands first, notes only where needed.

## Install
```bash
# Debian/Ubuntu (official repo)
sudo mkdir -p -m 755 /etc/apt/keyrings
wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
sudo apt update && sudo apt install gh
```

## Authentication
```bash
gh auth login                                # interactive
gh auth login --with-token < token.txt       # non-interactive (PAT from stdin)
gh auth status                               # show current auth
gh auth setup-git                            # use gh as git credential helper
export GH_TOKEN=...                          # env var auth, overrides stored creds
```

## Agent skills (`gh skill`, ≥ v2.90, public preview)
```bash
# Discover skills published by an org (query required)
gh skill search <query> --owner <org> --limit 50
gh search repos --owner <org> --topic agent-skills --json fullName,description
gh skill preview <owner>/<repo> [<skill>]          # inspect before installing

# Installed skills (scans all agent hosts, project + user scope)
gh skill list                                      # alias: gh skill ls
gh skill list --scope user|project --agent claude-code
gh skill list --json skillName,sourceURL,scope,version,pinned,path \
  -q '.[] | select(.sourceURL | test("<org>"; "i"))'

# Install / update / publish
gh skill install <owner>/<repo> <skill> [--pin vX.Y.Z]
gh skill update [--all]
gh skill publish --dry-run | --fix | --tag vX.Y.Z
```

## Extensions (`gh extension`)
No `--branch` flag. `--pin` = release tag (binary ext) or commit (script ext). Pinned exts are skipped by `upgrade`.
```bash
gh extension install <owner>/<repo> [--pin <tag|sha>]
gh extension list | upgrade [--all] | remove <name>   # name w/o "gh-" prefix; local install: only symlink removed

# Install from a branch, frozen at its current HEAD (script ext only)
gh extension install <owner>/<repo> --pin "$(gh api repos/<owner>/<repo>/commits/<branch> -q .sha)"

# Install tracking a branch (symlink to local clone; update with git pull)
gh repo clone <owner>/<repo> -- -b <branch> && cd <repo> && gh extension install .
```
