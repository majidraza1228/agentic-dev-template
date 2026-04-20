# 🤖 Agentic Dev Template

> A GitHub Template Repository that wires up **Claude**, **GitHub Copilot**, and **OpenAI Codex** with best-practice agentic programming configuration — out of the box.

Click **"Use this template"** on GitHub and every developer on your team gets a project pre-configured with:

- ✅ Layered instruction files for all three AI tools
- ✅ Sub-agent role definitions (Coder, Reviewer, Tester, Architect)
- ✅ Hooks for guardrails, audit logging, and HITL checkpoints
- ✅ Git worktree helpers for parallel agent execution
- ✅ GitHub Actions workflows that validate agent-generated PRs
- ✅ Devcontainer for reproducible isolated environments
- ✅ ADR templates for persistent agent memory
- ✅ Branch protection conventions baked in
- ✅ MCP server builder skill for Copilot and Claude — scaffold production-quality MCP servers with one command

---

## 📁 Repository Structure

```
agentic-dev-template/
│
│── CLAUDE.md                     ← Claude: project instructions (Layer 1)
│── AGENTS.md                     ← Codex + Claude: repo instructions (Layer 1)
│── CONTEXT.md                    ← Live project state (update regularly)
│── codex.yaml                    ← Codex: environment & tool config (Layer 2)
│
├── .claude/
│   ├── claude_config.json        ← MCP server connections
│   ├── agents/                   ← Sub-agent role definitions (Layer 2)
│   │   ├── coder.md
│   │   ├── reviewer.md
│   │   ├── tester.md
│   │   ├── architect.md
│   │   └── mcp-builder/              ← MCP server builder skill (Claude)
│   ├── hooks/                    ← Event hooks: guardrails & audit (Layer 3)
│   │   ├── pre-tool-use.sh
│   │   ├── post-tool-use.sh
│   │   └── audit.sh
│   └── memory/
│       └── decisions.md          ← Persistent project decisions (Layer 4)
│
├── .github/
│   ├── copilot-instructions.md   ← Copilot: repo-wide rules (Layer 1)
│   ├── agents/                   ← Copilot agent role files (Layer 3)
│   │   ├── coder.md
│   │   ├── reviewer.md
│   │   ├── tester.md
│   │   └── architect.md
│   ├── hooks/                    ← Copilot agent lifecycle hooks (Layer 3)
│   │   ├── session.json          ← SessionStart, PreCompact, Stop
│   │   ├── safety.json           ← PreToolUse: branch + command guard
│   │   ├── lint.json             ← PostToolUse: auto-lint on file write
│   │   ├── testing.json          ← PostToolUse: auto-test on file write
│   │   └── context.json          ← UserPromptSubmit: inject CONTEXT.md
│   ├── prompts/                  ← Reusable Copilot prompt templates
│   │   ├── add-feature.prompt.md
│   │   ├── review-pr.prompt.md
│   │   ├── generate-tests.prompt.md
│   │   └── build-mcp-server.prompt.md  ← /build-mcp-server slash command
│   ├── agents/                   ← Copilot agent role files (Layer 3)
│   │   ├── coder.md
│   │   ├── reviewer.md
│   │   ├── tester.md
│   │   ├── architect.md
│   │   └── mcp-builder.md            ← MCP server builder agent
│   ├── instructions/
│   │   └── mcp/                      ← MCP reference docs
│   │       ├── mcp_best_practices.md
│   │       ├── node_mcp_server.md
│   │       ├── python_mcp_server.md
│   │       └── evaluation.md
│   ├── decisions/                ← ADRs for Copilot context (Layer 4)
│   │   └── 000-adr-template.md
│   └── workflows/                ← CI/CD hooks for agent output
│       ├── agent-pr-check.yml
│       ├── label-agent-prs.yml
│       ├── security-scan.yml
│       └── audit-agent-changes.yml
│
├── .devcontainer/
│   ├── devcontainer.json         ← Isolated reproducible environment
│   └── scripts/
│       ├── post-create.sh
│       └── post-start.sh
│
├── scripts/
│   ├── pre-task.sh               ← Pre-task validation hook
│   ├── post-task.sh              ← Post-task verification hook
│   ├── worktree-agent.sh         ← Helper: spin up parallel agent worktrees
│   ├── hook-session-start.sh     ← Branch guard + context injection
│   ├── hook-pre-tool.sh          ← PreToolUse safety enforcement
│   ├── hook-post-tool-lint.sh    ← PostToolUse: inline lint
│   ├── hook-post-tool-test.sh    ← PostToolUse: inline test runner
│   ├── hook-prompt-submit.sh     ← CONTEXT.md auto-injection
│   ├── hook-pre-compact.sh       ← Session checkpoint before compaction
│   └── hook-stop-pr-draft.sh     ← PR description draft at session end
│
└── docs/
    └── decisions/
        └── 000-adr-template.md   ← ADR template for Codex memory
```

---

## 🚀 Getting Started

### Step 1 — Use this template
Click **"Use this template"** → **"Create a new repository"** on GitHub.

### Step 2 — Customize for your project

**All three tools:** Update these files with your project's specifics:
```
CLAUDE.md         → your stack, coding standards, key commands
AGENTS.md         → same as above (Codex reads this)
CONTEXT.md        → current sprint, known issues, active work
.github/copilot-instructions.md → same as above for Copilot
```

**Claude only:** Configure MCP servers you want:
```
.claude/claude_config.json  → add your GitHub token, DB URL, etc.
```

**Codex only:** Adjust environment setup:
```
codex.yaml  → your install commands, runtime versions, tool permissions
```

### Step 3 — Set branch protection rules
Go to your repo **Settings → Branches** and add protection rules:
- `main`: require PR + 1 reviewer + all CI passing
- `develop`: require PR + CI passing

### Step 4 — Set up the devcontainer (optional but recommended)
Open the repo in VS Code → click **"Reopen in Container"** when prompted.
This gives every developer and agent the same isolated environment.

### Step 5 — Make scripts executable
```bash
chmod +x scripts/pre-task.sh scripts/post-task.sh scripts/worktree-agent.sh
chmod +x scripts/hook-*.sh
chmod +x .claude/hooks/pre-tool-use.sh .claude/hooks/post-tool-use.sh .claude/hooks/audit.sh
```

### Step 6 — Configure your linter and test runner
Open these two scripts and uncomment the block for your stack:
```
scripts/hook-post-tool-lint.sh   ← pick ruff / eslint / shellcheck / golangci-lint / add your own
scripts/hook-post-tool-test.sh   ← pick pytest / jest / vitest / go test / add your own
```

### Step 7 — Optional: enable Spec-Driven Development mode

If your team wants requirements-first execution, you can enable Spec Kit in this template:

```bash
bash scripts/enable-spec-driven.sh
```

This initializes Spec Kit in-place and adds the `/speckit.*` workflow commands.

---

## 🌱 Spec-Driven Development (Optional Mode)

This template now supports two working styles:

1. **Standard agentic mode**: direct implementation with hooks/guardrails.
2. **Spec-driven mode**: `constitution → specify → plan → tasks → implement`.

Use spec-driven mode when work is ambiguous, cross-team, high-risk, or needs strong auditability.
Use standard mode for small, low-risk, tactical changes.

If you already have orchestration around `/plan`, keep it.  
Spec-driven mode complements it by adding:

- `spec.md` for explicit user outcomes
- `tasks.md` for traceable execution slices
- measurable success criteria before coding starts

### Does Spec-Driven help Codex, Claude, and Copilot?

**Yes**—with different strengths:

- **Copilot**: strongest native fit via `/speckit.*` prompts in this repo.
- **Claude**: very useful for spec clarification and architecture tradeoffs before coding.
- **Codex**: useful for deterministic execution from `tasks.md` once spec and plan are stable.

Details and rollout guidance: [`docs/spec-driven-development.md`](docs/spec-driven-development.md).

---

## ⚡ Copilot Agent Hooks

Hooks are deterministic shell commands wired into the Copilot agent lifecycle. They fire automatically — no manual steps required. The hook files live in `.github/hooks/` and the scripts they call live in `scripts/`.

### Hook files at a glance

| File | Event | What it does |
|------|-------|--------------|
| [`session.json`](.github/hooks/session.json) | `SessionStart`, `SubagentStart`, `PreCompact`, `Stop` | Branch guard, pre/post-task checks, context checkpoint, PR draft |
| [`safety.json`](.github/hooks/safety.json) | `PreToolUse` | Blocks pushes to protected branches, destructive git ops, and edits to CI workflows |
| [`lint.json`](.github/hooks/lint.json) | `PostToolUse` | Runs the linter on every file the agent writes |
| [`testing.json`](.github/hooks/testing.json) | `PostToolUse` | Runs the corresponding test file after every source file edit |
| [`context.json`](.github/hooks/context.json) | `UserPromptSubmit` | Auto-injects `CONTEXT.md` into every prompt |

### How each hook helps you

**`SessionStart` — branch guard**
The agent is blocked from starting work if you are on `main`, `master`, `develop`, or any `release/*` branch. It tells you exactly what branch name to create (`copilot/<description>`).

**`UserPromptSubmit` — live context injection**
`CONTEXT.md` is automatically prepended to every prompt. The agent always knows the active sprint, known issues, frozen paths, and upcoming changes — without you having to attach the file each time.

**`PreToolUse` — safety gate**
Before any tool fires, the agent's intended command is inspected:
- **Deny** — push/merge to a protected branch, edit `.github/workflows/`
- **Ask** — `rm -rf`, `git reset --hard`, `git push --force`, file deletion tools

**`PostToolUse` — inline lint**
Immediately after the agent writes or edits a file, the linter runs on that file. If there are errors, they are fed back to the agent as a system message so it self-corrects before moving to the next file.

Supported linters (auto-detected by file extension):

| Extension | Linter |
|-----------|--------|
| `.py` | `ruff` (falls back to `flake8`) |
| `.js` / `.ts` / `.jsx` / `.tsx` | `eslint` |
| `.sh` | `shellcheck` |
| `.go` | `golangci-lint` (falls back to `go vet`) |

To add your own, open [`scripts/hook-post-tool-lint.sh`](scripts/hook-post-tool-lint.sh) and add a block for your extension.

**`PostToolUse` — inline tests**
After editing a source file the agent automatically finds and runs the matching test file:

| Stack | Convention |
|-------|-----------|
| Python | `tests/test_<name>.py` |
| JS/TS | `<name>.test.<ext>` or `__tests__/<name>.test.<ext>` |
| Go | `go test ./<package>/...` |

Failures are injected back as a system message. The agent fixes the test before moving on.

**`PreCompact` — session checkpoint**
Before the context window is compacted, the agent captures current branch, recent commits, staged and unstaged files. After compaction it resumes from exactly where it was.

**`Stop` — PR description draft**
At the end of every session, a ready-to-paste PR description is generated with the title format, changed file list, commit log, and a reviewer checklist. Open your Draft PR and paste it in.

### Activating the hooks

Hooks are picked up automatically when the `.github/hooks/` folder exists — no configuration needed. The scripts must be executable:

```bash
chmod +x scripts/hook-*.sh
```

This is already done in the template. If you re-clone or add new hook scripts, run the command again.

### Configuring your linter and test runner

Open the two scripts below and uncomment the block that matches your stack (or add a new one):

```
scripts/hook-post-tool-lint.sh   ← linter configuration
scripts/hook-post-tool-test.sh   ← test runner configuration
```

Each file has clearly marked `TODO` sections with examples for common stacks.

---

## 🛠 Using Each Tool

### Claude (Claude Code / Cowork)
Claude automatically reads `CLAUDE.md` and `.claude/` on every session.
- Hooks fire automatically on every tool call
- Sub-agents defined in `.claude/agents/` are available for orchestration
- MCP servers in `claude_config.json` extend Claude's reach to GitHub, DBs, Slack, etc.

### GitHub Copilot (VS Code)
Copilot auto-loads `.github/copilot-instructions.md` every session.
- All hooks in `.github/hooks/` fire automatically at agent lifecycle events
- Reference agent files manually: `#file:.github/agents/reviewer.md`
- Use prompt templates from `.github/prompts/` via the Copilot Chat prompt picker
- Use `/build-mcp-server` to scaffold a new MCP server (see [MCP Server Development](#-mcp-server-development) below)
- All agent PRs trigger the validation workflows automatically

### OpenAI Codex
Codex auto-reads `AGENTS.md` (root + subdirectory) on every task.
- `codex.yaml` controls the sandbox environment
- `scripts/pre-task.sh` and `scripts/post-task.sh` are called in task instructions
- All Codex tasks create `codex/*` branches and open Draft PRs

---

## 🌿 Branch & Worktree Strategy

| Agent | Branch prefix | Opens PR to |
|-------|--------------|-------------|
| Claude | `agent/<description>` | `develop` |
| Copilot | `copilot/<description>` | `develop` |
| Codex | `codex/<description>` | `develop` |
| Humans | `feat/` or `fix/` | `develop` |

**Parallel agents with worktrees:**
```bash
# Spin up 3 parallel agent sessions (each isolated)
./scripts/worktree-agent.sh claude auth-refactor
./scripts/worktree-agent.sh copilot test-generation
./scripts/worktree-agent.sh codex docs-update
```

---

## � MCP Server Development

This template includes a built-in MCP server builder skill for both **GitHub Copilot** and **Claude**. Use it to scaffold production-quality MCP servers that connect LLMs to any external API.

### With GitHub Copilot — `/build-mcp-server`

The fastest way to start:
1. Open Copilot Chat in VS Code
2. Type `/build-mcp-server`
3. Fill in the `[REPLACE: ...]` placeholders (service name, language, transport, auth, tool list)
4. Run — Copilot will research, implement, test, and evaluate the server in four phases

Or attach the agent manually for a custom session:
```
#file:.github/agents/mcp-builder.md Build an MCP server for Stripe using TypeScript
```

### With Claude — mcp-builder skill

The Claude skill lives in `.claude/agents/mcp-builder/`. Invoke it by referencing `SKILL.md` in your Claude session:
```
Build an MCP server for Linear. Use the mcp-builder skill.
```

### What gets built

Both tools follow the same four-phase workflow:

| Phase | What happens |
|-------|--------------|
| 1 — Research | Fetches MCP protocol docs + SDK docs, studies the target API |
| 2 — Implement | Scaffolds project, builds API client, implements all tools with Zod/Pydantic validation and annotations |
| 3 — Test | Runs the build, verifies with MCP Inspector |
| 4 — Evaluate | Creates 10 realistic Q&A pairs to test LLM effectiveness |

### Reference docs

All reference material is in `.github/instructions/mcp/` (Copilot) and `.claude/agents/mcp-builder/reference/` (Claude):

| Doc | Contents |
|-----|----------|
| `mcp_best_practices.md` | Naming, transport, pagination, security, annotations |
| `node_mcp_server.md` | TypeScript/Zod patterns and complete example |
| `python_mcp_server.md` | Python/FastMCP/Pydantic patterns and complete example |
| `evaluation.md` | Evaluation Q&A creation and XML output format |

---

## �🔒 Human-in-the-Loop Rules

All agents are configured to **open Draft PRs** — never auto-merge.

A human must review and approve before any agent branch merges to `develop` or `main`. The GitHub Actions `agent-pr-check.yml` enforces this automatically.

Agents are blocked from modifying:
- Security/auth files
- Database migrations
- CI/CD workflows
- `.env` files or secrets

---

## 📖 Agentic Programming Guides
- [Claude Config Stack](../Claude-Config-Stack.md)
- [GitHub Copilot Config Stack](../GitHub-Copilot-Config-Stack.md)
- [OpenAI Codex Config Stack](../OpenAI-Codex-Config-Stack.md)

---

*Template version: April 2026 | Maintained by your team*
