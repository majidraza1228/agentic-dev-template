# Claude Memory — Pointer Index

> Claude's canonical project memory lives in `ai/`.
> This file is a thin pointer — do not duplicate content here.

---

## Always Load

1. `ai/RULES.md` — non-negotiable rules for every session
2. `ai/MEMORY.md` — project memory index (pointers to topics + ADRs)

## Load on Demand (max 3–5 per task)

| Topic | File |
|-------|------|
| Architecture | `ai/topics/architecture.md` |
| Auth | `ai/topics/auth.md` |
| Database | `ai/topics/db.md` |
| Deployment | `ai/topics/deployment.md` |
| Observability | `ai/topics/observability.md` |
| Repo map | `ai/topics/repo-map.md` |

## Canonical ADRs

`docs/decisions/` — one file per decision, named `NNN-short-title.md`

## Capture New Learnings

Append bullets to `ai/MEMORY_INBOX.md` at the end of each session.

---

## Claude CLI Kickoff Prompt

Copy-paste at the start of a new session:

```
1. Read ai/RULES.md and ai/MEMORY.md.
2. Tell me which additional ai/topics/*.md or docs/decisions/*.md files you need (max 5).
3. After finishing, write 5–10 bullets to ai/MEMORY_INBOX.md with file pointers.
```
