# TODO — Notable Issues & Improvements

> Tracked gaps from the initial template audit (2026-04-16).
> Check off items as you complete them.

---

## GitHub Repository Files

- [ ] **Add `.github/PULL_REQUEST_TEMPLATE.md`**
  A static PR template for human contributors. The `hook-stop-pr-draft.sh` script generates one dynamically for agents, but a static template helps enforce structure for all PRs.

- [ ] **Add `.github/ISSUE_TEMPLATE/`**
  Add `bug_report.md` and `feature_request.md` templates. Without these, GitHub shows a blank issue editor — structured templates improve agent and human issue quality.

- [ ] **Add `.github/CODEOWNERS`**
  Automatically request reviewers when agent PRs touch specific paths. Example:
  ```
  .github/workflows/   @your-username
  src/auth/            @your-username
  migrations/          @your-username
  ```

- [ ] **Add `SECURITY.md`**
  GitHub surfaces this as the vulnerability disclosure policy. Without it, there's no documented channel for responsible disclosure.

- [ ] **Add `.github/dependabot.yml`**
  Automated dependency update PRs. Prevents silent accumulation of CVEs in transitive dependencies.

- [ ] **Create missing `label-agent-prs.yml` workflow**
  The README documents this as a separate workflow under `.github/workflows/`, but the file does not exist. The `agent-pr-check.yml` already includes a `label-and-assign` job — decide whether this is intentional (remove from README) or create a lightweight standalone version.

---

## Environment & Onboarding

- [ ] **Add `.env.example`**
  Template file documenting all required environment variables without real values. New developers and agents need this to set up their environment. Should include at minimum: `GITHUB_TOKEN`, `DATABASE_URL`, and any project-specific vars from `devcontainer.json → remoteEnv`.

- [ ] **Add `SETUP.md` (or expand README)**
  A checklist of exactly what to fill in after cloning the template:
  - Fill in `CLAUDE.md` (project name, stack, commands)
  - Fill in `AGENTS.md` (same)
  - Fill in `CONTEXT.md` (current sprint)
  - Fill in `codex.yaml` (runtime versions, install commands)
  - Fill in `copilot-instructions.md` "Patterns to Follow" section
  - Set GitHub branch protection rules
  - Wire `GITHUB_TOKEN` in environment
  - Uncomment reviewers in `agent-pr-check.yml → label-and-assign`

---

## Template Content (Placeholders Still TODO)

- [ ] **`CLAUDE.md`** — Fill in project name, stack, key commands, file structure
- [ ] **`AGENTS.md`** — Fill in project name, stack, environment setup commands, protected paths
- [ ] **`CONTEXT.md`** — Fill in current sprint, known issues, frozen paths
- [ ] **`codex.yaml`** — Set runtime versions (`python`/`node`/`go`) and `install_commands`
- [ ] **`.github/copilot-instructions.md`** — Fill in "Patterns to Follow" reference files and "Avoid" anti-patterns
- [ ] **`.github/workflows/agent-pr-check.yml`** — Replace `echo "TODO: ..."` steps with real lint, test, and typecheck commands
- [ ] **`claude_config.json`** — Replace `YOUR_ORG/YOUR_REPO` with actual repo name; enable needed MCP servers

---

## Hook Architecture

- [ ] **Clarify `.github/hooks/*.json` vs `.claude/settings.local.json`**
  The `.github/hooks/` directory contains Claude Code-formatted hook configs (`SessionStart`, `PreToolUse`, etc.) but GitHub Copilot does not natively support this JSON hook format. These files are now merged into `.claude/settings.local.json` (the fix applied in this audit). Consider either:
  - Removing `.github/hooks/*.json` (now redundant) and updating the README
  - Keeping them as reference documentation with a note explaining they are not auto-loaded

- [ ] **Remove or archive old `.claude/hooks/` scripts**
  `pre-tool-use.sh`, `post-tool-use.sh`, and `audit.sh` in `.claude/hooks/` appear to be superseded by the newer `scripts/hook-*.sh` files. Verify these are no longer needed and remove them to avoid confusion about which hooks are active.

---

## CI / Workflows

- [ ] **Enable real GitHub Actions steps in `agent-pr-check.yml`**
  All lint, test, and typecheck steps are currently `echo "TODO: ..."`. These must be replaced before the CI provides any value. Also consider adding the `label-and-assign` step's reviewer list (currently commented out).

- [ ] **Configure Dependabot** (see GitHub Repository Files section above)
