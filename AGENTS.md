# AGENTS.md — Repository Instructions

> This file is automatically read by OpenAI Codex and Claude on every task/session.
> Subdirectory AGENTS.md files are merged with this root file (more specific takes precedence).

---

## Project Overview

<!-- TODO: Same as CLAUDE.md — describe your project -->
**Project:** [Your project name]
**Repo:** [org/repo-name]
**Stack:** [Your tech stack summary]

---

## Environment Setup

<!-- TODO: Replace with your actual setup commands -->
```bash
# Install dependencies
[your install command]

# Run database migrations (if applicable)
[your migration command]

# Verify setup
[your health-check command]
```

---

## Coding Standards

- Follow patterns established in existing code — read before writing
- All functions must have documentation comments
- Type-annotate everything (use strict mode)
- Error handling must be explicit — no silent failures
- Never use `print()` / `console.log()` for logging — use the project logger
- No hardcoded secrets, credentials, or environment-specific values

---

## Testing Requirements

- All new features must include tests
- Tests live in `tests/` mirroring `src/` structure
- Run the full test suite before marking any task complete
- Tests must pass — do not open a PR with failing tests

---

## Task Lifecycle Rules (Hooks)

### Before Writing Any Code
1. Run the test suite to confirm the baseline passes
2. Read `CONTEXT.md` for current project state
3. Identify and list the files you plan to modify
4. Check `docs/decisions/` for relevant architectural decisions

### While Working
- Commit after each logical unit of work
- Commit message format: `type(scope): description [codex]`
  - Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`
- Run linting after every file change
- If a test fails, fix it before moving to the next file

### Before Finishing
1. Run the full test suite — all must pass
2. Run linting — zero errors
3. Run type checking — zero errors
4. Write a clear PR description: what changed, why, what to review
5. Mark any security-sensitive changes with `# NEEDS_HUMAN_REVIEW`
6. Open PR as **Draft** — do not mark Ready for Review

---

## Git & Branch Policy

- **Branch naming:** `codex/<short-description>`
- **Never commit to:** `main`, `master`, `develop`, `release/*`
- **PR target:** `develop` (not `main`)
- **Always open as:** Draft PR
- **Checkpoint commits:** prefix with `[wip]` — squash before opening PR

---

## Protected — Do Not Modify

```
# These paths require human review — Codex must not touch them
[your-migration-folder]/     ← database migrations
[your-security-file]         ← auth/security code
.github/workflows/           ← CI/CD pipelines
*.env, *.pem, *.key          ← secrets and credentials
```

---

## Architecture Decisions

<!-- TODO: Add your key architectural decisions here as they accumulate -->
See `docs/decisions/` for full ADR history.

Key decisions:
- [Decision 1 — e.g. "We use PostgreSQL, not MongoDB"]
- [Decision 2 — e.g. "All money values stored as integer cents"]
- [Decision 3 — e.g. "Auth is JWT with 15-min expiry + Redis refresh tokens"]

---

## Patterns to Follow

<!-- TODO: Point Codex to reference implementations in your codebase -->
- New API endpoints: follow `[path/to/reference/file]` as the pattern
- Error handling: use `[your error class/pattern]`
- Database access: use `[your DB access pattern]`

---

## Context Window Management

- Never read lockfiles (`package-lock.json`, `poetry.lock`, etc.)
- Skip `node_modules/`, `.venv/`, `__pycache__/`, `dist/`, `build/`
- For files > 400 lines, use line ranges — read only what's needed
- If task scope exceeds 15 files, stop and clarify with the human
