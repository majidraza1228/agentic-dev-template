# MEMORY_INBOX.md — Capture Scratchpad

> Append-only during work sessions.
> Consolidate into MEMORY.md / topic files / ADRs every ~5 sessions or weekly.
> Format: date header → bullets with file pointers.
> Delete bullets after they are moved into a topic file or ADR.

---

## Consolidation Workflow

1. Review bullets below.
2. For stable facts → move to the relevant `ai/topics/*.md` file.
3. For architecture decisions → create `docs/decisions/NNN-title.md`.
4. For key pointers → add a row to `ai/MEMORY.md`.
5. Delete moved bullets and update the "Last consolidated" date in `ai/MEMORY.md`.

---

<!-- Example entry format:

## 2026-05-04
- [auth] JWT validation lives in `src/middleware/auth.py:validate_token` — called on every protected route
- [db] Migrations run with `alembic upgrade head`; rollback with `alembic downgrade -1`
- [deploy] Staging deploys automatically on push to `develop`; prod requires manual trigger in GitHub Actions
- [gotcha] The `User.updated_at` field is NOT auto-updated by the ORM — must set explicitly

-->

## <!-- date -->
<!-- Add your first capture bullets here -->
