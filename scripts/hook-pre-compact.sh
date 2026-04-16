#!/bin/bash
# scripts/hook-pre-compact.sh
# PreCompact hook — writes a checkpoint summary before context compaction.
# Captures current branch, recent git activity, and a timestamp so the agent
# can resume without losing track of what it was doing.

set -e

TIMESTAMP=$(date '+%Y-%m-%d %H:%M')
BRANCH=$(git branch --show-current 2>/dev/null || echo "unknown")
RECENT_COMMITS=$(git log --oneline -5 2>/dev/null || echo "(no commits yet)")
CHANGED_FILES=$(git diff --name-only HEAD 2>/dev/null | head -20 || echo "(none)")
STAGED_FILES=$(git diff --cached --name-only 2>/dev/null | head -10 || echo "(none)")

MESSAGE=$(python3 -c "
import json, sys

branch        = sys.argv[1]
timestamp     = sys.argv[2]
recent        = sys.argv[3]
changed       = sys.argv[4]
staged        = sys.argv[5]

msg = f'''## Context Checkpoint — {timestamp}

**Branch:** {branch}

**Recent commits:**
{recent}

**Unstaged changes:**
{changed if changed.strip() else '(none)'}

**Staged (ready to commit):**
{staged if staged.strip() else '(none)'}

---
Context compaction is about to happen. Resume from where you left off after compaction.
'''.strip()

print(json.dumps({'systemMessage': msg}))
" "$BRANCH" "$TIMESTAMP" "$RECENT_COMMITS" "$CHANGED_FILES" "$STAGED_FILES" 2>/dev/null || echo "{}")

echo "$MESSAGE"
exit 0
