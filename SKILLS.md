# Skills Guide

This repo includes 21 agent skills from [mattpocock/skills](https://github.com/mattpocock/skills), installed under `.claude/skills/`. Each skill is a specialized prompt that extends what Claude Code can do in a session.

---

## Planning & Design

### `/to-prd`
Converts your current conversation into a Product Requirements Document and files it as a GitHub issue. Useful when you've been discussing a feature and want to lock it down as a spec without starting from scratch.

### `/to-issues`
Breaks a plan, spec, or PRD into independently-grabbable GitHub issues using vertical slices. Saves time translating a design doc into an actionable backlog.

### `/grill-me`
Interviews you relentlessly about a plan or design until every decision branch is resolved. Use this before committing to an approach — it surfaces assumptions and edge cases you haven't considered.

### `/design-an-interface`
Generates multiple radically different interface designs for a module using parallel sub-agents. Useful when you want to compare API shapes before picking one.

### `/request-refactor-plan`
Conducts a user interview to build a detailed refactor plan with tiny, safe commits, then files it as a GitHub issue. Use this before touching a complex area of the codebase.

### `/domain-model`
Stress-tests your plan against the existing domain model, sharpens terminology, and updates `CONTEXT.md` and ADRs inline as decisions crystallise. Best used alongside `/ubiquitous-language`.

---

## Development

### `/tdd`
Runs a red-green-refactor loop to build features or fix bugs test-first. Useful when you want to drive implementation from failing tests rather than writing code speculatively.

### `/triage-issue`
Investigates a bug by exploring the codebase, identifies the root cause, and files a GitHub issue with a TDD-based fix plan. Saves the time of manually digging through code to reproduce and document a bug.

### `/improve-codebase-architecture`
Finds refactoring and deepening opportunities in the codebase, guided by domain language and ADRs. Use when the codebase feels hard to navigate or test.

### `/scaffold-exercises`
Creates exercise directory structures with sections, problems, solutions, and explainers. Useful for course or workshop authors.

### `/migrate-to-shoehorn`
Migrates test files from `as` type assertions to `@total-typescript/shoehorn`. Specific to TypeScript projects using Total TypeScript patterns.

---

## Tooling & Setup

### `/setup-pre-commit`
Sets up Husky pre-commit hooks with lint-staged (Prettier), type checking, and tests. Gets your commit safety net in place in one step.

### `/git-guardrails-claude-code`
Installs Claude Code hooks that block dangerous git commands (force push, reset --hard, branch -D, clean) before they execute. Protects against accidental destructive operations in agent sessions.

### `/write-a-skill`
Creates new agent skills with proper structure and bundled resources. Use this when you want to add your own reusable skill to the repo.

---

## Writing & Knowledge

### `/edit-article`
Edits and improves article drafts by restructuring sections, improving clarity, and tightening prose.

### `/ubiquitous-language`
Extracts a DDD-style ubiquitous language glossary from the current conversation, flags ambiguities, and saves canonical terms to `UBIQUITOUS_LANGUAGE.md`. Useful for aligning a team on shared terminology.

### `/obsidian-vault`
Searches, creates, and manages notes in an Obsidian vault with wikilinks and index notes.

### `/github-triage`
Triages GitHub issues through a label-based state machine — creating, reviewing, and preparing issues for agent workflows.

### `/qa`
An interactive QA session where you report bugs conversationally and the agent files GitHub issues, using codebase context to enrich the reports.

### `/zoom-out`
Tells the agent to step back and explain the broader context of a section of code. Use when you're lost in a specific area and need the bigger picture.

### `/caveman`
Switches Claude to ultra-compressed communication mode — drops filler and pleasantries while keeping full technical accuracy. Cuts token usage ~75% for long sessions.
