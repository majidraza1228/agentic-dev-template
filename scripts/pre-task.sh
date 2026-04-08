#!/bin/bash
# scripts/pre-task.sh
# Pre-task validation hook — run before any agent starts coding.
# Called automatically by codex.yaml setup_commands for Codex.
# Should also be called manually for Claude and Copilot tasks.
#
# Usage: bash scripts/pre-task.sh

set -e
echo "🔍 Running pre-task checks..."
echo ""

FAILED=0

# ---------------------------------------------------------------------------
# 1. Verify required environment variables are set
# ---------------------------------------------------------------------------
echo "1. Checking environment variables..."
REQUIRED_VARS=(
  # TODO: Add your required env vars
  # "DATABASE_URL"
  # "REDIS_URL"
)

for VAR in "${REQUIRED_VARS[@]}"; do
  if [ -z "${!VAR}" ]; then
    echo "  ❌ Missing required env var: $VAR"
    FAILED=1
  else
    echo "  ✅ $VAR is set"
  fi
done

# ---------------------------------------------------------------------------
# 2. Run baseline tests to confirm project is in a working state
# ---------------------------------------------------------------------------
echo ""
echo "2. Running baseline test suite..."

# TODO: Replace with your test command
# Example for pytest:
# if python -m pytest tests/smoke/ -q --tb=short 2>&1; then
#   echo "  ✅ Baseline tests pass"
# else
#   echo "  ❌ Baseline tests failing — fix before starting agent task"
#   FAILED=1
# fi

# Example for Jest:
# if npx jest --testPathPattern="smoke" --passWithNoTests --silent 2>&1; then
#   echo "  ✅ Baseline tests pass"
# else
#   echo "  ❌ Baseline tests failing"
#   FAILED=1
# fi

echo "  ℹ️  TODO: configure your test command in this script"

# ---------------------------------------------------------------------------
# 3. Check for uncommitted changes (warn, don't block)
# ---------------------------------------------------------------------------
echo ""
echo "3. Checking git status..."
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "  ⚠️  Uncommitted changes detected. Consider stashing before agent task:"
  echo "     git stash push -m 'before-agent-task-$(date +%Y%m%d-%H%M)'"
else
  echo "  ✅ Clean working tree"
fi

# ---------------------------------------------------------------------------
# 4. Remind agent about current context
# ---------------------------------------------------------------------------
echo ""
echo "4. Context reminder:"
if [ -f "CONTEXT.md" ]; then
  echo "  ℹ️  Read CONTEXT.md for current project state"
  echo "     Key sections: Active Work, Known Issues, Frozen Paths"
else
  echo "  ⚠️  CONTEXT.md not found — consider creating one"
fi

# ---------------------------------------------------------------------------
# Result
# ---------------------------------------------------------------------------
echo ""
if [ "$FAILED" -eq 1 ]; then
  echo "❌ Pre-task checks FAILED. Fix the issues above before starting."
  exit 1
else
  echo "✅ Pre-task checks passed. Agent may proceed."
fi
