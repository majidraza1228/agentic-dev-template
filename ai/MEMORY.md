# MEMORY.md — Project Memory Index

> Index only. Keep under 200 lines.
> Every entry is a pointer — no long explanations here.
> Full content lives in topic files or ADRs.
> Last consolidated: <!-- TODO: update date when you consolidate MEMORY_INBOX -->

---

## Golden Commands

```bash
# TODO: fill in your real commands
install:   [your install command]
dev:       [your dev command]
test:      [your test command]
lint:      [your lint command]
typecheck: [your typecheck command]
```

---

## Project Map

```text
# TODO: update with your real structure
src/           <- source code
tests/         <- mirrors src/ structure
docs/          <- documentation
docs/decisions/<- ADRs (canonical architecture decisions)
ai/            <- agent memory system (this folder)
scripts/       <- hooks and utility scripts
specs/         <- spec-driven feature artifacts (when used)
```

---

## Key Constraints

<!-- Add the 5–10 most important non-obvious constraints here as bullets.
     Examples:
     - All monetary values stored as integer cents — never floats
     - Auth tokens expire in 15 min; refresh tokens in Redis with matching TTL
     - The uploadToS3 utility handles all file uploads — don't create alternatives
     - Multi-tenant: every DB query must filter by tenant_id
-->
- [TODO: constraint 1]
- [TODO: constraint 2]

---

## Topic Pointers

| Topic | File | When to load |
|-------|------|--------------|
| Architecture overview | `ai/topics/architecture.md` | Any structural change |
| Auth & security | `ai/topics/auth.md` | Auth, middleware, tokens |
| Database & migrations | `ai/topics/db.md` | Schema, queries, migrations |
| Deployment & infra | `ai/topics/deployment.md` | CI/CD, env vars, infra |
| Observability | `ai/topics/observability.md` | Logging, metrics, tracing |
| Repo map | `ai/topics/repo-map.md` | Orientation, new features |

---

## ADR Pointers

Canonical decisions live in `docs/decisions/`.

| ADR | Title | Status |
|-----|-------|--------|
| [000](../docs/decisions/000-adr-template.md) | ADR template | Template |
<!-- Add rows as you create ADRs: ADR-001, ADR-002, etc. -->

---

## Recent Inbox (unconsolidated)

> Consolidated items move to topic files or the ADR table above.
> See `ai/MEMORY_INBOX.md` for the full append log.

<!-- paste 1-line summaries of recent INBOX items here after consolidation -->
