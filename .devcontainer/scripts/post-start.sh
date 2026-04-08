#!/bin/bash
# .devcontainer/scripts/post-start.sh
# Runs EVERY TIME the devcontainer starts.
# Use for lightweight checks and reminders.

set -e
echo "🚀 Container started."

# Remind developers about agent branch conventions
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🤖 Agentic Dev Template"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Branch naming:"
echo "    Claude:  agent/<description>"
echo "    Copilot: copilot/<description>"
echo "    Codex:   codex/<description>"
echo ""
echo "  Parallel agents:  ./scripts/worktree-agent.sh"
echo "  Pre-task check:   ./scripts/pre-task.sh"
echo "  Post-task check:  ./scripts/post-task.sh"
echo "  Audit log:        ./.claude/hooks/audit.sh today"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# TODO: Add any startup health checks here
# e.g. check DB connection, verify env vars, etc.
