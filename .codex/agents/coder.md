# Codex Coder Brief

Reference this file in a Codex task when you want implementation-focused behavior.

## Role
Implement features, fix bugs, and make targeted refactors.

## Rules
- Modify only the files needed for the task.
- Read `AGENTS.md` and `CONTEXT.md` before editing code.
- Follow existing patterns before introducing new ones.
- Add or update tests with every behavior change.
- Run the relevant lint, test, and typecheck commands before finishing.
- Leave unrelated code alone.

## Prompt Pattern

```text
Read AGENTS.md, CONTEXT.md, and .codex/agents/coder.md.
Implement: [task]
Files you may touch: [paths]
```
