# Codex Quickstart

Use this guide when you want consistent, repo-aware Codex sessions.

## What Codex Reads Automatically

Codex automatically reads:

- `AGENTS.md`
- Any more specific `AGENTS.md` files in subdirectories

Codex does not automatically read `.codex/`, `CONTEXT.md`, or `docs/decisions/` unless you tell it to.

## Recommended Prompt Pattern

Start most tasks with:

```text
Read AGENTS.md and CONTEXT.md first.
```

Add more files only when they matter:

- `.codex/agents/coder.md` for implementation work
- `.codex/agents/reviewer.md` for review-only work
- `.codex/agents/tester.md` for test-focused work
- `.codex/agents/architect.md` for planning and tradeoff analysis
- `.codex/prompts/` for reusable task starters
- `.codex/memory/decisions.md` for short durable project context
- `docs/decisions/...` for ADR-level constraints

## Example Prompts

You can also start from the templates in `.codex/prompts/` and fill in the placeholders.

### Implement a feature

```text
Read AGENTS.md, CONTEXT.md, and .codex/agents/coder.md.
Implement: add rate limiting to the API client.
Files you may touch: src/api/client.py, tests/api/test_client.py
Run the relevant tests before finishing.
```

### Review a diff

```text
Read AGENTS.md, CONTEXT.md, and .codex/agents/reviewer.md.
Review the current diff for bugs, regressions, and missing tests.
Do not make changes unless you find something that should be fixed immediately.
```

### Plan before coding

```text
Read AGENTS.md, CONTEXT.md, docs/decisions/000-adr-template.md, and .codex/agents/architect.md.
Design an implementation plan for migrating authentication to a shared service.
Call out tradeoffs and protected paths.
```

## Practical Workflow

1. Start on a non-protected branch such as `codex/<task>`.
2. Tell Codex to read `CONTEXT.md` for live project state.
3. Reference one `.codex/agents/*.md` file when you want tighter task behavior.
4. Keep file scope explicit for larger changes.
5. Run `scripts/post-task.sh` before opening the Draft PR.

## When To Use Repo Skills

Repo-local skills live in `.agents/skills/`.

Use them when the task matches one of those workflows closely, for example:

- `tdd` for red-green-refactor work
- `write-a-skill` for creating a new skill
- `github-triage` for issue triage workflows

If you want Codex to use one, name it directly in the task.

## Reusable Prompt Templates

Use these files when you want a faster starting point:

- [`.codex/prompts/add-feature.prompt.md`](../.codex/prompts/add-feature.prompt.md)
- [`.codex/prompts/generate-tests.prompt.md`](../.codex/prompts/generate-tests.prompt.md)
- [`.codex/prompts/plan-change.prompt.md`](../.codex/prompts/plan-change.prompt.md)
- [`.codex/prompts/review-diff.prompt.md`](../.codex/prompts/review-diff.prompt.md)

## Minimal Team Convention

If your team wants one default pattern, use:

```text
Read AGENTS.md and CONTEXT.md first. If relevant, also read the matching file in .codex/agents/. Then complete the task and run verification before finishing.
```
