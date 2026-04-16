#!/bin/bash
# scripts/hook-session-start.sh
# SessionStart / SubagentStart hook for Copilot agent.
# Checks the current git branch and blocks work if on a protected branch.
# Outputs a system message as JSON for context injection.

set -e

PROTECTED_BRANCHES=("main" "master" "develop")
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "")

# ---------------------------------------------------------------------------
# 1. Block if on a protected branch
# ---------------------------------------------------------------------------
for PROTECTED in "${PROTECTED_BRANCHES[@]}"; do
  if [[ "$CURRENT_BRANCH" == "$PROTECTED" ]]; then
    echo "{\"stopReason\":\"You are on the protected branch '$CURRENT_BRANCH'. Create a new branch before starting: git checkout -b copilot/<short-description>\"}"
    exit 2
  fi
done

# Check for release/* branches
if echo "$CURRENT_BRANCH" | grep -qE '^release/'; then
  echo "{\"stopReason\":\"You are on a protected release branch '$CURRENT_BRANCH'. Create a feature branch before starting.\"}"
  exit 2
fi

# ---------------------------------------------------------------------------
# 2. Inject branch + context reminder as system message
# ---------------------------------------------------------------------------
CONTEXT_SUMMARY=""
if [ -f "CONTEXT.md" ]; then
  CONTEXT_SUMMARY=$(python3 -c "
import re, sys
text = open('CONTEXT.md').read()
# Extract the Active Work table section
match = re.search(r'## Current Sprint.*?(?=\n---|\Z)', text, re.DOTALL)
if match:
    print(match.group(0).strip()[:800])
else:
    print('CONTEXT.md found — read it for active sprint, known issues, and frozen paths.')
" 2>/dev/null || echo "Read CONTEXT.md for current project state.")
fi

BRANCH_MSG="Working on branch: ${CURRENT_BRANCH:-'(detached HEAD)'}"

MESSAGE=$(python3 -c "
import json, sys
msg = sys.argv[1] + '\n\n' + sys.argv[2]
print(json.dumps({'systemMessage': msg}))
" "$BRANCH_MSG" "$CONTEXT_SUMMARY" 2>/dev/null || echo "{}")

echo "$MESSAGE"
exit 0
