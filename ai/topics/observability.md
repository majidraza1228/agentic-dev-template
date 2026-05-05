# observability.md — Logging, Metrics & Tracing

> Load when adding logging, debugging production issues, or touching observability code.

---

## Logger Setup

- Logger module: `[path/to/logger.py or logging config]`
- Use `[e.g. structlog / Python logging / Winston]` — do NOT use `print()` or `console.log()`
- Log format: `[e.g. JSON structured logs]`
- Log levels: `DEBUG` (local only), `INFO` (key events), `WARNING` (recoverable issues), `ERROR` (failures)

---

## How to Log

```python
# TODO: replace with your logger import and call pattern
from [module] import logger

logger.info("event_name", key="value", user_id=user.id)
logger.error("event_name", error=str(e), traceback=True)
```

---

## What to Log (and what not to)

**Always log:**
- Request start/end with status code and duration
- Auth failures
- External API calls (start, result, duration)
- Background job start/completion/failure

**Never log:**
- Passwords, tokens, or raw credentials
- Full request bodies (may contain PII)
- Excessive DEBUG in production

---

## Metrics

- Platform: `[e.g. Prometheus / Datadog / CloudWatch]`
- Dashboard: `[URL or location]`
- Key metrics to watch: `[e.g. request latency p99, error rate, queue depth]`

---

## Tracing

- Platform: `[e.g. OpenTelemetry / Jaeger / Honeycomb]`
- Trace IDs: `[e.g. injected via X-Trace-Id header; included in all logs]`

---

## Alerting

- Alerts configured in: `[location]`
- On-call rotation: `[location or N/A]`
- If you add a new critical path, consider whether it needs an alert

---

## Local Debugging Tips

- View logs: `[e.g. docker compose logs -f app]`
- Increase log level: `[e.g. set LOG_LEVEL=DEBUG in .env]`
