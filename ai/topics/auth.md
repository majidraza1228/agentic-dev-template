# auth.md — Authentication & Authorization

> Load when touching auth, tokens, middleware, permissions, or user identity.

---

## How Auth Works

<!-- TODO: describe your auth flow -->
[e.g. "JWT-based. Client POSTs credentials to /auth/login → receives access_token (15 min) + refresh_token (7 days). Refresh tokens stored in Redis keyed by user_id."]

---

## Key Files

| File | What it does |
|------|--------------|
| `[path/to/auth_middleware.py]` | Validates JWT on every protected route |
| `[path/to/auth_routes.py]` | Login, logout, refresh endpoints |
| `[path/to/token_utils.py]` | Token encode/decode, expiry logic |
| `[path/to/permissions.py]` | Role/permission checks |

---

## Token Details

- Access token expiry: `[e.g. 15 minutes]`
- Refresh token expiry: `[e.g. 7 days]`
- Stored in: `[e.g. Redis, key = user:{user_id}:refresh]`
- Algorithm: `[e.g. HS256]`
- Secret location: `[e.g. env var AUTH_SECRET]`

---

## Protected vs Public Routes

- Protected routes require: `[e.g. Authorization: Bearer <token> header]`
- Public routes: `[e.g. /auth/login, /auth/refresh, /health]`
- Admin-only routes: `[e.g. /admin/* — requires role=admin in token claims]`

---

## Common Failure Modes

- `[e.g. 401 on expired token]` → client should call `/auth/refresh`
- `[e.g. 403 vs 401 distinction]` → 401 = unauthenticated, 403 = unauthorized
- `[e.g. token revocation]` → [how it works or if it doesn't exist yet]

---

## Local Dev Notes

- Test accounts: `[e.g. admin@example.com / test1234]`
- Bypass auth in tests: `[e.g. use the mock_user fixture in tests/conftest.py]`
- Do NOT skip auth middleware in non-test code
