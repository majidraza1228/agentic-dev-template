# db.md — Database & Migrations

> Load when touching schema, queries, migrations, or data access patterns.

---

## DB Setup

- Engine: `[e.g. PostgreSQL 15]`
- ORM / query builder: `[e.g. SQLAlchemy 2.x]`
- Migration tool: `[e.g. Alembic]`
- Connection string: `[e.g. env var DATABASE_URL]`

---

## Key Files

| File | What it does |
|------|--------------|
| `[path/to/db.py]` | Session factory, engine setup |
| `[path/to/models/]` | ORM model definitions |
| `[path/to/migrations/]` | Alembic migration files |
| `[path/to/repositories/]` | Data access layer (if used) |

---

## Migration Commands

```bash
# Create a new migration (auto-detect from model changes)
[e.g. alembic revision --autogenerate -m "description"]

# Apply all pending migrations
[e.g. alembic upgrade head]

# Roll back one migration
[e.g. alembic downgrade -1]

# Check current revision
[e.g. alembic current]
```

---

## Data Conventions

<!-- Non-obvious rules agents must follow -->
- `[e.g. All monetary values stored as integer cents — never floats]`
- `[e.g. Soft deletes: set deleted_at timestamp, never DELETE rows]`
- `[e.g. Multi-tenant: every table has tenant_id; every query must filter by it]`
- `[e.g. Timestamps: use UTC everywhere; no naive datetimes]`

---

## Common Failure Modes

- `[e.g. Missing tenant_id filter causes data leakage across tenants]`
- `[e.g. Auto-generated migrations miss index changes — always review before applying]`
- `[e.g. N+1 queries on related models — use joinedload() or selectinload()]`

---

## Local Dev

- Reset local DB: `[e.g. make db-reset]`
- Seed data: `[e.g. python scripts/seed.py]`
- DB admin UI: `[e.g. http://localhost:5050 — pgAdmin]`
