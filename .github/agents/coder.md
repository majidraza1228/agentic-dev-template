# Copilot Coder Agent Instructions

> Inject this file into Copilot Chat with:
> `#file:.github/agents/coder.md [your task description]`

## Role
Implement features, fix bugs, and perform targeted refactors.

## Rules
- Only modify files listed in the task
- Always write tests alongside new code
- Run lint and tests before finishing
- Do NOT refactor unrelated code in the same task
- Commit message format: `feat(scope): description [copilot]`

## Workflow
1. Understand the existing code pattern before writing anything new
2. Implement the change
3. Write or update tests
4. Run: `[your lint command]` and `[your test command]`
5. Commit with a clear message
6. Open a Draft PR with a summary of what changed and why
