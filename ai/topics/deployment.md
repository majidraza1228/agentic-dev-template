# deployment.md — Deployment & Infrastructure

> Load when touching CI/CD, environment variables, infrastructure, or release process.

---

## Environments

| Env | Branch | Deploy trigger | URL |
|-----|--------|----------------|-----|
| local | any | manual | localhost |
| staging | `develop` | auto on push | `[staging URL]` |
| production | `main` | manual trigger | `[prod URL]` |

---

## CI/CD

- Platform: `[e.g. GitHub Actions]`
- Pipelines: `.github/workflows/`
- Do NOT modify workflows without human approval

---

## Key Pipeline Files

| File | What it does |
|------|--------------|
| `.github/workflows/ci.yml` | Runs tests + lint on every PR |
| `.github/workflows/deploy-staging.yml` | Deploys to staging on `develop` push |
| `.github/workflows/deploy-prod.yml` | Deploys to prod (manual trigger) |

---

## Environment Variables

- Template: `.env.example` (safe to read)
- Real secrets: `.env` — never read, never commit
- Injected via: `[e.g. GitHub Actions secrets / Doppler / AWS Secrets Manager]`

Required vars:
```
DATABASE_URL
AUTH_SECRET
[add others]
```

---

## Deployment Process

```bash
# Staging (auto): push to develop
git push origin develop

# Production (manual):
# 1. Merge develop → main
# 2. Trigger deploy-prod workflow in GitHub Actions
# 3. Monitor logs at [log location]
```

---

## Rollback

- `[e.g. Re-run the previous successful workflow run in GitHub Actions]`
- `[e.g. DB rollback: alembic downgrade -1 on the prod server]`

---

## Known Gotchas

- `[e.g. DB migrations run automatically on deploy — ensure they're backward-compatible]`
- `[e.g. Redis cache is not cleared on deploy — flush manually if schema changes affect cached data]`
