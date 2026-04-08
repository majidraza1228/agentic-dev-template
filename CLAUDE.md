# CLAUDE.md — Project Instructions

> This file is automatically read by Claude at the start of every session.
> Replace the placeholder sections below with your project's specifics.

---

## Project Overview

<!-- TODO: Describe your project in 2-3 sentences -->
**Project:** [Your project name]
**Purpose:** [What it does and who it's for]
**Status:** [Active development / Maintenance / etc.]

---

## Tech Stack

<!-- TODO: Fill in your stack -->
- **Language:** [e.g. Python 3.12 / Node 20 / Go 1.22]
- **Framework:** [e.g. FastAPI / Next.js / Gin]
- **Database:** [e.g. PostgreSQL 15 / MongoDB / SQLite]
- **Cache:** [e.g. Redis / Memcached]
- **Testing:** [e.g. pytest / Jest / go test]
- **Linting:** [e.g. ruff + mypy / eslint + tsc / golangci-lint]

---

## Key Commands

<!-- TODO: Replace with your actual commands -->
```bash
# Install dependencies
[your install command]

# Run development server
[your dev command]

# Run tests
[your test command]

# Run linting
[your lint command]

# Run type checking
[your typecheck command]
```

---

## Coding Standards

<!-- TODO: Customize for your team -->
- Follow the conventions in existing code before introducing new patterns
- All new functions must have documentation comments
- No commented-out code in commits
- Every PR must include tests for new behaviour
- Never hardcode secrets — use environment variables

---

## File Structure

<!-- TODO: Describe your project layout -->
```
src/           ← source code
tests/         ← test files (mirror src/ structure)
docs/          ← documentation
scripts/       ← utility scripts
```

---

## Agent Branch Policy

- **Never commit to:** `main`, `master`, `develop`, `release/*`
- **Your branch:** `agent/<short-description>` (e.g. `agent/add-rate-limiting`)
- **One task = one branch = one PR**
- **All PRs open as Draft** — human reviews before marking ready

---

## Human Approval Required Before

- Deleting any existing file
- Modifying auth, security, or payment code
- Changing database schema or migration files
- Modifying `.github/workflows/` CI config
- Reading or writing any `.env`, `.pem`, or secret files
- Pushing to any protected branch

---

## Context Window Management

- Never read `package-lock.json`, `yarn.lock`, `poetry.lock`, or lockfiles
- Skip `node_modules/`, `.venv/`, `__pycache__/`, `dist/`, `build/`
- For files > 400 lines, read only the relevant section
- After completing a research phase, write a summary before proceeding

---

## MCP Servers Available

See `.claude/claude_config.json` for connected tools.
Current connections: [list your active MCP servers here after configuring]

---

## Memory

See `.claude/memory/decisions.md` for architectural decisions and context.
