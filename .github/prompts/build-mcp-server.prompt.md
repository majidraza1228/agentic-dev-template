---
mode: agent
description: Build a production-quality MCP server to integrate an external API or service
---
#file:.github/agents/mcp-builder.md
#file:.github/copilot-instructions.md
#file:.github/instructions/mcp/mcp_best_practices.md

Build an MCP server for the following service/API:

**Service:** [REPLACE: name of the service or API — e.g. "Stripe", "Notion", "Linear"]
**Language:** [REPLACE: TypeScript (recommended) or Python]
**Transport:** [REPLACE: streamable-http (remote) or stdio (local)]
**Auth method:** [REPLACE: API key / OAuth 2.1 / Bearer token — and where it comes from]
**API docs URL:** [REPLACE: link to the API documentation]

**Tools to implement:**
- [REPLACE: list key operations — e.g. "list projects", "create issue", "search users"]
- [REPLACE: add more as needed]

**Out of scope (do NOT implement):**
- [REPLACE: operations to skip — e.g. "billing endpoints", "admin-only endpoints"]

---

Follow the four-phase workflow in the agent instructions:

1. **Research** — Fetch MCP and SDK docs, read best practices, study the target API
2. **Implement** — Scaffold project, build API client, implement all tools with validation and annotations
3. **Test** — Build must pass, test with MCP Inspector
4. **Evaluate** — Create 10 realistic evaluation Q&A pairs in XML format

When done:
1. Run build — zero errors
2. Confirm MCP Inspector connects and lists all tools
3. Open a Draft PR with the list of tools implemented and evaluation file path
