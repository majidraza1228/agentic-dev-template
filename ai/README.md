# AI Memory System

Shared memory layer for Claude CLI, GitHub Copilot, and OpenAI Codex.
All three tools read from here — one source of truth, no duplication.

---

## Structure

```
ai/
  RULES.md            # always-loaded non-negotiables (style, arch, git, security)
  MEMORY.md           # index: pointers to topics + ADRs (<200 lines)
  MEMORY_INBOX.md     # append-only capture scratchpad
  topics/
    repo-map.md       # where things live; file paths and entry points
    architecture.md   # system design, layers, key decisions summary
    auth.md           # tokens, middleware, permissions
    db.md             # schema, ORM, migrations, data conventions
    deployment.md     # CI/CD, envs, release process
    observability.md  # logging, metrics, tracing
  README.md           # this file
```

Canonical ADRs live in `docs/decisions/NNN-title.md` — linked from `MEMORY.md`.

---

## Daily Workflow

| When | Action |
|------|--------|
| Start of task | Read `RULES.md` + `MEMORY.md`; pick ≤5 relevant topic files |
| During task | Append new learnings to `MEMORY_INBOX.md` |
| Every ~5 sessions | Consolidate INBOX → topic files or ADRs; update `MEMORY.md` index |

---

## Tool Bootstrap Prompts

**Claude CLI** (paste at session start):
```
1. Read ai/RULES.md and ai/MEMORY.md.
2. Tell me which additional ai/topics/*.md or docs/decisions/*.md files you need (max 5).
3. After finishing, write 5–10 bullets to ai/MEMORY_INBOX.md with file pointers.
```

**Copilot Chat** (paste at session start or when context drifts):
```
Follow ai/RULES.md. Use ai/MEMORY.md as the project memory index.
Before suggesting changes, check relevant files in ai/topics/.
If a new architectural decision is made, propose an ADR in docs/decisions/.
```

**Codex** (add to task instructions):
```
Read ai/RULES.md and ai/MEMORY.md first.
Load up to 5 relevant topic files from ai/topics/ before coding.
```

---

## Memory Budget Rules

- Always load: `RULES.md` + `MEMORY.md`
- Per task: max **3–5** topic files
- Topic file target size: **1–2 pages** — split if larger
- MEMORY.md hard limit: **200 lines**

---

## What to Store (and what not to)

**Store here:**
- Build/run/test commands
- Architecture decisions and tradeoffs
- Integration contracts (API shapes, DB constraints)
- Known pitfalls and common errors
- "How we do X here" conventions

**Do not store:**
- Raw logs or giant transcripts
- Full copies of code
- Anything that changes daily (use pointers instead)
- Git history (use `git log`)
