# repo-map.md — Where Things Live

> Load this when starting a new feature or orienting in an unfamiliar area.
> Keep it factual and file-path-specific. No explanations — just pointers.

---

## Core Source Layout

```text
# TODO: fill in your real paths
src/
  [module-a]/          <- [what it does]
  [module-b]/          <- [what it does]
  utils/               <- shared utilities
  config.py            <- app configuration
  main.py              <- entry point

tests/
  [module-a]/          <- mirrors src/[module-a]
  [module-b]/          <- mirrors src/[module-b]
  conftest.py          <- shared fixtures
```

---

## Config & Secrets

- Config loaded from: `[path]`
- Env var template: `.env.example`
- Never read: `.env`, `.env.local`, `*.pem`, `*.key`

---

## Key Entry Points

- App startup: `[path/to/main.py or index.ts]`
- Route registration: `[path]`
- DB connection: `[path]`
- Auth middleware: `[path]`

---

## Where to Add Things

| Thing | Where |
|-------|-------|
| New API endpoint | `[path]` — follow `[reference file]` |
| New DB model | `[path]` — follow `[reference file]` |
| New migration | `[path]` — run `[migration command]` |
| New test | `tests/[mirrored-path]` |
| New script | `scripts/` |

---

## Test & Lint Commands (quick reference)

```bash
[test command]
[lint command]
[typecheck command]
```
