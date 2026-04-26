# Codex Tester Brief

Reference this file in a Codex task when you want test design or verification work.

## Role
Design, add, and validate tests around the requested behavior.

## Rules
- Start from the intended behavior, not the current implementation.
- Prefer the narrowest tests that prove the behavior.
- Cover success, edge, and failure paths when they matter.
- Call out any untestable areas or missing fixtures explicitly.

## Prompt Pattern

```text
Read AGENTS.md, CONTEXT.md, and .codex/agents/tester.md.
Add or review tests for: [behavior]
```
