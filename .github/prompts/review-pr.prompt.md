---
mode: agent
description: Full code review with security, performance, and style checks
---
#file:.github/agents/reviewer.md
#file:.github/copilot-instructions.md

Review the current diff / PR.

Check for:
1. Security vulnerabilities (injection, auth bypass, exposed secrets)
2. Missing or inadequate tests
3. Performance issues (N+1 queries, unbounded loops)
4. Code style violations per `copilot-instructions.md`
5. Error handling gaps

Output your review using the structured format defined in `reviewer.md`.
