#!/bin/bash
# scripts/post-task.sh
# Post-task verification hook — run after an agent finishes coding.
# All checks must pass before opening a PR.
#
# Usage: bash scripts/post-task.sh

set -e
echo "🔍 Running post-task verification..."
echo ""

FAILED=0

# ---------------------------------------------------------------------------
# 1. Run full test suite
# ---------------------------------------------------------------------------
echo "1. Running full test suite..."
# TODO: Replace with your test command
# if python -m pytest tests/ -v --tb=short 2>&1; then
#   echo "  ✅ All tests pass"
# else
#   echo "  ❌ Tests failing — do not open PR until tests pass"
#   FAILED=1
# fi
echo "  ℹ️  TODO: configure your test command"

# ---------------------------------------------------------------------------
# 2. Run linting
# ---------------------------------------------------------------------------
echo ""
echo "2. Running linter..."
# TODO: Replace with your lint command
# if ruff check . 2>&1; then
#   echo "  ✅ Lint clean"
# else
#   echo "  ❌ Lint errors — fix before opening PR"
#   FAILED=1
# fi
echo "  ℹ️  TODO: configure your lint command"

# ---------------------------------------------------------------------------
# 3. Run type checking
# ---------------------------------------------------------------------------
echo ""
echo "3. Running type checker..."
# TODO: Replace with your typecheck command
# if mypy src/ --strict 2>&1; then
#   echo "  ✅ No type errors"
# else
#   echo "  ❌ Type errors — fix before opening PR"
#   FAILED=1
# fi
echo "  ℹ️  TODO: configure your typecheck command"

# ---------------------------------------------------------------------------
# 4. Check for debug artifacts left by agent
# ---------------------------------------------------------------------------
echo ""
echo "4. Checking for debug artifacts..."
DEBUG_PATTERNS=("console.log.*debug" "print(.*debug" "TODO.*REMOVE" "FIXME.*BEFORE.*PR" "pdb.set_trace" "debugger;")
FOUND_DEBUG=0

for pattern in "${DEBUG_PATTERNS[@]}"; do
  MATCHES=$(git diff --unified=0 HEAD~1 2>/dev/null | grep -E "^\+.*$pattern" || true)
  if [ -n "$MATCHES" ]; then
    echo "  ⚠️  Found debug artifact: $pattern"
    FOUND_DEBUG=1
  fi
done

if [ "$FOUND_DEBUG" -eq 0 ]; then
  echo "  ✅ No debug artifacts found"
fi

# ---------------------------------------------------------------------------
# 5. Summarize what changed
# ---------------------------------------------------------------------------
echo ""
echo "5. Change summary:"
echo "   Files changed: $(git diff --name-only HEAD~1 2>/dev/null | wc -l | tr -d ' ')"
git diff --stat HEAD~1 2>/dev/null | tail -1 || echo "   (run from a branch with commits)"

# ---------------------------------------------------------------------------
# Result
# ---------------------------------------------------------------------------
echo ""
if [ "$FAILED" -eq 1 ]; then
  echo "❌ Post-task checks FAILED. Fix the issues above before opening a PR."
  exit 1
else
  echo "✅ Post-task checks passed. Ready to open a Draft PR."
  echo ""
  echo "Next steps:"
  echo "  1. git push origin \$(git branch --show-current)"
  echo "  2. Open a Draft PR targeting 'develop'"
  echo "  3. Fill in the PR description: what changed, why, what to review"
fi
