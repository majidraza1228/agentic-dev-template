# GitHub Copilot Instructions

> This file is automatically loaded by GitHub Copilot on every session.
> Replace the placeholders below with your project's specifics.

---

## Project Memory System

The shared agent memory lives in `ai/`:

- `ai/RULES.md` — always-applicable rules (load first)
- `ai/MEMORY.md` — index of pointers to topic files and ADRs
- `ai/topics/*.md` — on-demand topic files (load max 3–5 relevant ones per task)
- `docs/decisions/` — canonical ADRs

**Copilot Chat bootstrap** (paste at session start or when context drifts):

```
Follow ai/RULES.md. Use ai/MEMORY.md as the project memory index.
Before suggesting changes, check relevant files in ai/topics/.
If a new architectural decision is made, propose an ADR in docs/decisions/.
```

---

## Project Overview

<!-- TODO: Replace with your project details -->
**Project:** [Your project name]
**Repo:** [org/repo-name]
**Purpose:** [What this project does and who it is for]
**Status:** [Active development / Maintenance / Internal tool / etc.]

---

## Tech Stack

<!-- TODO: Fill in your stack -->
- **Language:** [e.g. Python 3.12 / Node 20 / Go 1.22]
- **Framework:** [e.g. FastAPI / Next.js / Gin]
- **Database:** [e.g. PostgreSQL 15 / MongoDB / SQLite]
- **Cache:** [e.g. Redis / Memcached / None]
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

## File Structure

<!-- TODO: Describe your project layout -->
```text
src/           <- source code
tests/         <- test files mirroring src/ structure
docs/          <- documentation and ADRs
scripts/       <- utility scripts and hooks
```

---

## Coding Standards

- Follow existing patterns before introducing new ones.
- All new functions must have documentation comments.
- Type-annotate everything when the language and codebase support it.
- Error handling must be explicit; do not ignore failures silently.
- Do not use `print()` or `console.log()` for production logging; use the project logger.
- Never hardcode secrets, credentials, or environment-specific values.
- Avoid commented-out dead code in commits.

---

## Testing Requirements

- All new features and bug fixes must include tests.
- Tests should live in `tests/` or the repo’s established mirrored structure.
- Cover happy path, edge cases, and error states when relevant.
- Run the full test suite before marking any task complete.
- Do not open a PR with failing tests.

---

## Optional Spec-Driven Workflow

For medium or large tasks, use spec-driven mode:
1. Create or update `specs/<feature>/spec.md` with scenarios and acceptance criteria.
2. Create or update `specs/<feature>/plan.md`.
3. Create or update `specs/<feature>/tasks.md`.
4. Implement only what maps to those artifacts.

If the work is tiny and low risk, you may skip the full artifacts and document the reason in the PR.

---

## Task Lifecycle Rules

### Before Writing Any Code
1. Run the baseline test suite to confirm the current branch is healthy.
2. Read `CONTEXT.md` for current project state.
3. Identify the files you expect to modify.
4. Check `docs/decisions/` for relevant architectural decisions.

### While Working
- Keep one feature or fix per branch.
- Run linting after every file change when the hook or environment supports it.
- If a test fails, fix it before moving to the next file.
- Avoid unrelated refactors in the same task.

### Before Finishing
1. Run the full test suite.
2. Run linting.
3. Run type checking.
4. Write a clear Draft PR description covering what changed, why, and what to review.
5. Mark any security-sensitive changes with `# NEEDS_HUMAN_REVIEW`.
6. Open the PR as **Draft**.

---

## Git & Branch Policy

- Branch naming: `copilot/<short-description>`
- Never commit directly to `main`, `master`, `develop`, or `release/*`
- PR target: `develop`
- Always open PRs as **Draft**
- PR title format: `type(scope): short description`

---

## Human Approval Required Before

- Deleting any existing file
- Modifying auth, security, payment, or other sensitive code
- Changing database schema or migration files
- Modifying `.github/workflows/` CI configuration
- Reading or writing `.env`, `.pem`, `.key`, or other secret files
- Changes affecting more than 10 files

---

## Protected Paths

```text
# Replace these placeholders with your real protected paths
[your-migration-folder]/     <- database migrations
[your-security-file]         <- auth or security code
.github/workflows/           <- CI/CD pipelines
*.env, *.pem, *.key          <- secrets and credentials
```

---

## Architecture Decisions

See `docs/decisions/` for full ADR history.

Key decisions:
- [Decision 1 — e.g. "We use PostgreSQL, not MongoDB"]
- [Decision 2 — e.g. "All money values stored as integer cents"]
- [Decision 3 — e.g. "Auth is JWT with 15-minute expiry and Redis refresh tokens"]

---

## Patterns to Follow

<!-- TODO: Point agents to reference implementations in your codebase -->
- New API endpoints: follow `[path/to/reference/file]`
- New components or modules: follow `[path/to/reference/file]`
- Error handling: use `[your error class/pattern]`
- Tests: use `[path/to/reference/test]`

---

## Context Window Management

- Never read lockfiles such as `package-lock.json`, `yarn.lock`, or `poetry.lock`.
- Skip `node_modules/`, `.venv/`, `__pycache__/`, `dist/`, and `build/`.
- For files larger than 400 lines, read only the relevant section.
- If task scope grows too large, narrow the change or split the work.

---

## Copilot Workspace Files

- `.github/copilot-instructions.md` is the primary instruction file Copilot reads automatically.
- `.github/agents/` contains reusable role files for Copilot sessions.
- `.github/prompts/` contains reusable prompt templates and slash-command content.
- `.github/hooks/` contains Copilot lifecycle hook definitions.
- `.github/instructions/` contains extra reference material for specialized workflows.
