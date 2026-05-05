# architecture.md — System Design Overview

> Load when making structural changes, adding new modules, or evaluating design options.
> Keep diagrams simple; prefer file paths over abstract box-and-arrow descriptions.

---

## High-Level Shape

<!-- TODO: describe the system in 3–5 sentences -->
[e.g. "Monolithic FastAPI app with a PostgreSQL database. Background tasks run via Celery with Redis as the broker. No microservices — all business logic lives in src/."]

---

## Layer Responsibilities

| Layer | Path | Responsibility |
|-------|------|----------------|
| API / Routes | `[path]` | HTTP handling, request validation, response shaping |
| Services | `[path]` | Business logic, orchestration |
| Data access | `[path]` | DB queries, ORM models |
| Utils | `[path]` | Shared helpers, no business logic |

---

## Key Design Decisions

> Full ADRs in `docs/decisions/`. This is a summary view.

- [e.g. "Chose PostgreSQL over MongoDB — see ADR-001"]
- [e.g. "No repository pattern — service layer calls ORM directly"]
- [e.g. "Auth is JWT, 15-min expiry — see ADR-002"]

---

## What NOT to Do (known pitfalls)

<!-- Anti-patterns discovered during the project -->
- [e.g. "Don't add business logic to route handlers — put it in services"]
- [e.g. "Don't create new DB session factories — use the one in src/db.py"]

---

## External Integrations

| Service | Purpose | How we call it |
|---------|---------|----------------|
| [e.g. Stripe] | [Payments] | `src/integrations/stripe.py` |
| [e.g. SendGrid] | [Email] | `src/integrations/email.py` |
