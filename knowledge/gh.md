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
