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
│   │   └── architect.md
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
│   ├── prompts/                  ← Reusable Copilot prompt templates
│   │   ├── add-feature.prompt.md
│   │   ├── review-pr.prompt.md
│   │   └── generate-tests.prompt.md
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
│   └── worktree-agent.sh         ← Helper: spin up parallel agent worktrees
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
chmod +x .claude/hooks/pre-tool-use.sh .claude/hooks/post-tool-use.sh .claude/hooks/audit.sh
```

---

## 🛠 Using Each Tool

### Claude (Claude Code / Cowork)
Claude automatically reads `CLAUDE.md` and `.claude/` on every session.
- Hooks fire automatically on every tool call
- Sub-agents defined in `.claude/agents/` are available for orchestration
- MCP servers in `claude_config.json` extend Claude's reach to GitHub, DBs, Slack, etc.

### GitHub Copilot (VS Code)
Copilot auto-loads `.github/copilot-instructions.md` every session.
- Reference agent files manually: `#file:.github/agents/reviewer.md`
- Use prompt templates from `.github/prompts/` via the Copilot Chat prompt picker
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

## 🔒 Human-in-the-Loop Rules

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
