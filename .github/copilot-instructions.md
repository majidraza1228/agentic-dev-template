# GitHub Copilot Instructions

> This file is automatically loaded by GitHub Copilot on every session.
> Customize the TODO sections for your project.

---

## Project

<!-- TODO: Fill in your project details -->
**Project:** [Your project name]
**Stack:** [Your tech stack — e.g. "Node 20, TypeScript, React 18, PostgreSQL"]
**Purpose:** [One sentence about what this project does]

---

## Code Style

<!-- TODO: Customize for your team -->
- Follow conventions already established in the codebase — read before writing
- All new functions must have documentation comments
- No commented-out dead code in commits
- Use descriptive variable names — avoid abbreviations
- Prefer explicit over implicit

---

## Testing

<!-- TODO: Customize for your test framework -->
- Write tests for all new code
- Test files mirror source structure: `tests/[path/to/source].test.[ext]`
- Cover: happy path, edge cases, and error states
- Test names: `it('should [behaviour] when [condition]')`
- Run tests before opening any PR

---

## Security Rules

- **Never** hardcode secrets, API keys, tokens, or passwords
- Always use environment variables for sensitive configuration
- Sanitize all user input before use in queries or commands
- Use parameterized queries — never string concatenation in SQL
- Never log passwords, tokens, sessions, or PII

---

## Git & Branch Policy

- **Never** commit to `main`, `master`, `develop`, or `release/*`
- Agent branch naming: `copilot/<short-description>`
- One feature/fix per branch, one PR per branch
- Always open PRs as **Draft** first
- PR title format: `type(scope): short description`

---

## Human Approval Required Before

- Deleting any existing file
- Modifying auth, security, or payment code
- Changing database schema or migration files
- Modifying `.github/workflows/` CI configuration
- Changes affecting more than 10 files

---

## Patterns to Follow

<!-- TODO: Point Copilot to reference files in your codebase -->
Reference implementations:
- New API endpoint: `[path/to/reference/file]`
- New component: `[path/to/reference/file]`
- New test: `[path/to/reference/test]`

---

## Avoid

<!-- TODO: Customize with your project's anti-patterns -->
- Creating duplicate utilities — check if one already exists
- Introducing new dependencies without discussing in the PR
- Mixing refactoring with new features in the same PR
- Skipping error handling
