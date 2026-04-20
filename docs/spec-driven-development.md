# Spec-Driven Development in this Template

This template supports an optional Spec-Driven Development (SDD) mode using GitHub Spec Kit.

## Why adopt SDD

Adopt SDD when you need:
- clear requirement boundaries before coding
- traceability from requirement to code and tests
- better collaboration across product/engineering/QA
- safer delivery for larger or riskier changes

## When to use it

Use SDD for:
- new features with multiple user journeys
- work involving architecture or API changes
- compliance/audit-sensitive delivery
- initiatives split across multiple contributors or agents

Use lightweight planning for:
- tiny bug fixes
- localized refactors with no behavior changes
- throwaway prototypes

## If you already use `/plan`

Keep using `/plan`; it is still useful.  
SDD adds two missing layers:
1. `spec.md` (what/why and acceptance criteria)
2. `tasks.md` (execution traceability and sequencing)

Recommended loop:
`constitution -> specify -> plan -> tasks -> implement`

## Tool fit: Copilot vs Claude vs Codex

- **Copilot**: best end-to-end ergonomics with `/speckit.*` prompt flow.
- **Claude**: strong for requirement clarification and design reasoning.
- **Codex**: strong for deterministic implementation once tasks are explicit.

All three benefit from SDD because artifacts reduce ambiguity and improve reproducibility.

## Enable Spec Kit in this repo

Run:

```bash
bash scripts/enable-spec-driven.sh
```

Then follow your preferred assistant flow:
- `/speckit.constitution`
- `/speckit.specify`
- `/speckit.plan`
- `/speckit.tasks`
- `/speckit.implement`
