# RULES.md — Always-Loaded Agent Rules

> These rules apply in every session, for every tool (Claude, Copilot, Codex).
> Replace the bracketed placeholders with your project's specifics.
> Do NOT store volatile state here — put that in CONTEXT.md.

---

## Stack Rules

- **Language:** [e.g. Python 3.12] — use only stdlib + approved dependencies
- **Framework:** [e.g. FastAPI] — follow its idioms, do not reinvent routing
- **Database:** [e.g. PostgreSQL] — all access via the ORM/query builder, no raw SQL strings
- **Testing:** [e.g. pytest] — every new feature needs a test; every bug fix needs a regression test
- **Linting:** [e.g. ruff + mypy] — run lint after every file change

---

## Code Rules

- Minimum code that solves the problem — no speculative features
- No abstractions for single-use code
- Match existing style, even if you'd write it differently
- No error handling for impossible scenarios — validate only at system boundaries
- No hardcoded secrets, credentials, or environment-specific values
- No `print()` / `console.log()` in production paths — use the project logger
- No commented-out dead code in commits

---

## Testing Rules

- Cover: happy path, edge cases, error states
- Tests live in `tests/` mirroring `src/` structure
- Do not open a PR with failing tests
- Run the full suite before marking any task complete

---

## Git Rules

- Branch naming: `agent/<short-description>` (or tool-specific: `claude/`, `copilot/`, `codex/`)
- Never commit to `main`, `master`, `develop`, or `release/*`
- PR target: `develop`
- Always open PRs as **Draft**
- Commit format: `type(scope): description [agent]`
- Allowed types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`

---

## Human Approval Required Before

- Deleting any existing file
- Modifying auth, security, payment, or other sensitive code
- Changing database schema or migration files
- Modifying `.github/workflows/`
- Reading or writing `.env`, `.pem`, `.key`, or other secret files
- Pushing to any protected branch

---

## Protected Paths

```text
[your-migration-folder]/     <- database migrations
[your-security-file]         <- auth or security code
.github/workflows/           <- CI/CD pipelines
*.env, *.pem, *.key          <- secrets and credentials
```

---

## Context Window Hygiene

- Never read lockfiles (`package-lock.json`, `yarn.lock`, `poetry.lock`)
- Skip `node_modules/`, `.venv/`, `__pycache__/`, `dist/`, `build/`
- For files >400 lines, read only the relevant section
- Always-load: `ai/RULES.md` + `ai/MEMORY.md`
- Per task: max 3–5 topic files from `ai/topics/`
