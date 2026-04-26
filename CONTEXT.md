# CONTEXT.md — Live Project State

> Template only: replace the sample headings and placeholders with your real project state before depending on this file during agent sessions.

> Keep this file up to date. Reference it at the start of complex agent sessions:
> - Claude: it reads `.claude/memory/` automatically; mention CONTEXT.md in your prompt for complex tasks
> - Codex: add "Read CONTEXT.md first" to your task instructions or AGENTS.md
> - Copilot: inject with `#file:CONTEXT.md` at the start of a Copilot Chat session
>
> Last updated: <!-- TODO: update this date -->

---

## Current Sprint / Active Work

<!-- TODO: Update with what's actively being worked on -->
| Area | Status | Branch | Notes |
|------|--------|--------|-------|
| [Feature/task name] | In Progress | [branch name] | [any notes] |
| [Feature/task name] | Blocked | [branch name] | [blocker description] |
| [Feature/task name] | Review | [PR link] | [review status] |

---

## Known Issues

<!-- TODO: List bugs and tech debt agents should be aware of -->
- **[Issue description]** — [impact / avoid touching X until fixed]
- **[Issue description]** — [ticket/PR reference]

---

## Upcoming Changes — Agent Caution

<!-- TODO: List planned changes agents should not conflict with -->
- **[Area]:** [description of planned change — agents should avoid coupling to this]
- **[Area]:** [description — e.g. "DB schema change planned for orders table — do not add new columns"]

---

## Frozen / Do Not Touch Right Now

<!-- TODO: List anything temporarily frozen -->
- `[path/to/file-or-folder]` — [reason, e.g. "being refactored in PR #42"]
- `[path/to/file-or-folder]` — [reason, e.g. "waiting on external API change"]

---

## Recently Merged (last 2 weeks)

<!-- TODO: Brief log of recent significant changes -->
- **[date]:** [what was merged] — [PR link]
- **[date]:** [what was merged] — [PR link]

---

## Team Notes for Agents

<!-- TODO: Anything else agents should know about current project state -->
- [Any special instructions for this period]
- [External dependencies or blockers]
- [Upcoming deadlines that affect scope]
