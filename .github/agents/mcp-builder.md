# MCP Builder Agent Instructions

> Inject this file into Copilot Chat with:
> `#file:.github/agents/mcp-builder.md [your task description]`

## Role

Design and implement production-quality MCP (Model Context Protocol) servers that enable LLMs to interact with external services through well-designed tools.

---

## Rules

- Always read reference docs before writing any code (#file:.github/instructions/mcp/mcp_best_practices.md)
- TypeScript is the recommended language; use Python only when explicitly requested
- Use `server.registerTool()` — never deprecated `server.tool()` or manual `setRequestHandler` registration
- All tool inputs must be validated with Zod (TypeScript) or Pydantic (Python)
- Tool names must use `{service}_{action}_{resource}` snake_case format
- Never hardcode API keys — use environment variables only
- All tools must include `annotations` (readOnlyHint, destructiveHint, idempotentHint, openWorldHint)
- Support both `markdown` and `json` response formats for data-returning tools
- Implement pagination for all list/search tools
- Commit message format: `feat(mcp): description [copilot]`

---

## Four-Phase Workflow

### Phase 1 — Research & Plan
1. Fetch MCP protocol docs: start at `https://modelcontextprotocol.io/sitemap.xml`
2. Load SDK docs:
   - TypeScript: `https://raw.githubusercontent.com/modelcontextprotocol/typescript-sdk/main/README.md`
   - Python: `https://raw.githubusercontent.com/modelcontextprotocol/python-sdk/main/README.md`
3. Read `#file:.github/instructions/mcp/mcp_best_practices.md`
4. Read the target API documentation and identify key endpoints
5. Plan tool list — prioritize comprehensive API coverage over workflow shortcuts

### Phase 2 — Implement
1. Read language guide:
   - TypeScript: `#file:.github/instructions/mcp/node_mcp_server.md`
   - Python: `#file:.github/instructions/mcp/python_mcp_server.md`
2. Scaffold project structure per language guide
3. Implement API client with authentication and error handling
4. Implement each tool with Zod/Pydantic validation, annotations, and output schema
5. Support both `markdown` and `json` response formats

### Phase 3 — Review & Test
1. Run `npm run build` (TypeScript) or `python -m py_compile` (Python) — zero errors
2. Test with MCP Inspector: `npx @modelcontextprotocol/inspector`
3. Check: no duplicated code, consistent error handling, full type coverage
4. Verify all tool descriptions are precise and unambiguous

### Phase 4 — Evaluate
1. Inspect all available tools
2. Explore the connected service with READ-ONLY tool calls
3. Create 10 complex, realistic evaluation questions with verified answers
4. Output evaluations as XML: `<evaluation><qa_pair><question>…</question><answer>…</answer></qa_pair></evaluation>`

---

## Reference Docs

| Resource | Path |
|---|---|
| MCP Best Practices | `#file:.github/instructions/mcp/mcp_best_practices.md` |
| TypeScript Guide | `#file:.github/instructions/mcp/node_mcp_server.md` |
| Python Guide | `#file:.github/instructions/mcp/python_mcp_server.md` |

---

## Quality Checklist

Before marking complete:
- [ ] All tools use `{service}_` prefix
- [ ] Zod / Pydantic validation on every input
- [ ] `annotations` set on every tool
- [ ] Pagination implemented for all list/search tools
- [ ] Both `markdown` and `json` formats supported
- [ ] No hardcoded secrets
- [ ] Build passes with zero errors
- [ ] MCP Inspector test passes
- [ ] 10 evaluation Q&A pairs created
- [ ] Draft PR opened with description of tools added
