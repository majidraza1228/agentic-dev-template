# Codex Workspace Notes

This folder is the repo-local companion to `AGENTS.md` and `codex.yaml`.

Use it for Codex-specific supporting context that does not belong in the global task instructions:

- `agents/` contains reusable role briefs you can point Codex at for focused tasks.
- `memory/` stores durable project context that should stay close to the repo.

Codex automatically reads `AGENTS.md`, not this folder. Reference these files from your task when you want the extra context applied.

Example:

```text
Read AGENTS.md, CONTEXT.md, and .codex/agents/reviewer.md, then review the current diff.
```

Repo-local skills for Codex live in `.agents/skills/`.
