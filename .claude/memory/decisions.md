# Project Decisions — Claude Memory

> This file is Claude's persistent project memory.
> Add decisions here as they are made so Claude carries context across sessions.
> Format: date, decision, and reason.

---

## Decision Log

<!-- Template for each entry:
## YYYY-MM-DD: [Short decision title]
**Decision:** [What was decided]
**Reason:** [Why this was chosen over alternatives]
**Impact:** [Files/areas affected]
-->

## [Date]: [Your first decision]
**Decision:** [e.g. "Use PostgreSQL as the primary database"]
**Reason:** [e.g. "Team SQL expertise; relational data model fits our domain"]
**Impact:** [e.g. "All data access through SQLAlchemy ORM; Alembic for migrations"]

---

## Technical Constraints to Remember

<!-- List non-obvious technical constraints Claude should always keep in mind -->
- [e.g. "All monetary values stored as integer cents — never floats"]
- [e.g. "Auth tokens expire in 15 min; refresh tokens stored in Redis with matching TTL"]
- [e.g. "The uploadToS3 utility in src/utils/storage handles all file uploads — don't create alternatives"]

---

## User / Team Preferences

<!-- Communication and style preferences for this project -->
- Prefer concise PR descriptions focused on "why" not just "what"
- Code review comments should always explain the reason behind a suggestion
- Commit messages follow Conventional Commits format

---

## Known Workarounds

<!-- Temporary fixes or technical debt that Claude should know about -->
- [e.g. "GET /users/{id} returns 500 on soft-deleted users — bug #342, not yet fixed"]
- [e.g. "Redis connection pool configured conservatively — do not increase pool size without testing"]
