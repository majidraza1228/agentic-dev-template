#!/bin/bash
# scripts/hook-stop-pr-draft.sh
# Stop hook — generates a PR description draft at the end of every agent session.
# Printed to stdout so the agent can include it in its final summary.
# The agent should attach this to the Draft PR it opens.

set -e

BRANCH=$(git branch --show-current 2>/dev/null || echo "unknown")
TIMESTAMP=$(date '+%Y-%m-%d')
BASE_BRANCH="develop"

# Gather changed files against base branch
CHANGED_FILES=$(git diff --name-only "$BASE_BRANCH"..."$BRANCH" 2>/dev/null \
  || git diff --name-only HEAD~5 2>/dev/null \
  || echo "(could not determine changed files)")

FILE_COUNT=$(echo "$CHANGED_FILES" | grep -c . 2>/dev/null || echo "?")

# Recent commits on this branch
COMMITS=$(git log --oneline "$BASE_BRANCH".."$BRANCH" 2>/dev/null \
  || git log --oneline -10 2>/dev/null \
  || echo "(no commits)")

# Infer PR type from branch name
PR_TYPE="feat"
if echo "$BRANCH" | grep -qiE '(fix|bug|hotfix)'; then PR_TYPE="fix"; fi
if echo "$BRANCH" | grep -qiE '(refactor|refact)'; then PR_TYPE="refactor"; fi
if echo "$BRANCH" | grep -qiE '(test|spec)'; then PR_TYPE="test"; fi
if echo "$BRANCH" | grep -qiE '(docs|doc)'; then PR_TYPE="docs"; fi
if echo "$BRANCH" | grep -qiE '(chore|config|ci)'; then PR_TYPE="chore"; fi

# Derive a scope from the branch name (strip prefix like copilot/ or codex/)
SCOPE=$(echo "$BRANCH" | sed 's|^[^/]*/||' | sed 's|-| |g' | cut -c1-40)

PR_DRAFT=$(python3 -c "
import sys
branch     = sys.argv[1]
pr_type    = sys.argv[2]
scope      = sys.argv[3]
commits    = sys.argv[4]
files      = sys.argv[5]
file_count = sys.argv[6]
date       = sys.argv[7]

print(f'''---
## PR Description Draft

**Title:** \`{pr_type}({scope}): <short description>\`
**Branch:** \`{branch}\` → \`develop\`
**Date:** {date}

---

### What changed
<!-- Describe what was changed and why -->
- 

### Why
<!-- Link to issue, ticket, or explain rationale -->
- Closes #

### How to test
<!-- Steps for the reviewer to verify the change -->
1. 
2. 

### Checklist
- [ ] Tests added / updated
- [ ] Lint passes
- [ ] Type checks pass
- [ ] No hardcoded secrets
- [ ] No commented-out dead code
- [ ] CONTEXT.md updated if sprint state changed

### Files changed ({file_count} files)
\`\`\`
{files[:1500]}
\`\`\`

### Commits
\`\`\`
{commits[:1000]}
\`\`\`
---
> ⚠️  Open this PR as **Draft** — do not mark Ready for Review until all checklist items pass.
''')
" "$BRANCH" "$PR_TYPE" "$SCOPE" "$COMMITS" "$CHANGED_FILES" "$FILE_COUNT" "$TIMESTAMP" 2>/dev/null || echo "")

if [ -n "$PR_DRAFT" ]; then
  MESSAGE=$(python3 -c "
import json, sys
print(json.dumps({'systemMessage': sys.argv[1]}))
" "$PR_DRAFT" 2>/dev/null || echo "{}")
  echo "$MESSAGE"
fi

exit 0
