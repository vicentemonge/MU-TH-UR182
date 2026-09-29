# AGENTS.md — Behaviour Contract for AI Agents

This file defines how any AI agent, assistant, or automated tool must behave when reading from or writing to this repository. Read it before doing anything else.

## 1. Purpose of this repository
MU-TH-UR182 is a shared knowledge base and interchange point between humans and AI agents. It stores prompts, conversation contexts, distilled knowledge, and supporting files so that any entity can pick up where another left off.

## 2. Mandatory reading order
1. `AGENTS.md` (this file)
2. `README.md` (index of all content)
3. Only the files relevant to your current task

## 3. Communication style
- Audience: senior Linux engineer / programmer.
- Be precise and concise. Exact commands and options first, explanation only when asked.
- Correct wrong assumptions directly.
- Prefer targeted edits over broad restructuring.

## 4. Writing rules
- **Never commit secrets**: tokens, passwords, private keys, credentials. Redact as `***`.
- Knowledge files go in `knowledge/`, one file per topic, lowercase, kebab-case (e.g. `knowledge/gh.md`).
- Every new or renamed file **must** be added to the index in `README.md` in the same commit.
- Append or edit in place; do not rewrite existing files wholesale unless asked.
- Use GitHub-flavoured Markdown. Put commands in fenced code blocks with a language tag.

## 5. Commit conventions
- Small, atomic commits.
- Message format: `<area>: <imperative summary>` — e.g. `knowledge/gh: add pr commands`.
- Do not force-push `main`.

## 6. Directory layout
| Path | Content |
|------|---------|
| `AGENTS.md` | This behaviour contract |
| `README.md` | Human intro + index of all content |
| `knowledge/` | Distilled reference notes, one topic per file |

New top-level directories (e.g. `prompts/`, `contexts/`) may be created when needed; document them here and in `README.md`.
