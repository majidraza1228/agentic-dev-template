#!/bin/bash
# scripts/hook-prompt-submit.sh
# UserPromptSubmit hook — injects CONTEXT.md into every agent prompt.
# Ensures the agent always has current sprint state, known issues,
# frozen paths, and upcoming changes in context without the user
# having to manually attach the file.

set -e

[ ! -f "CONTEXT.md" ] && exit 0

# Read CONTEXT.md, skipping the header boilerplate (first 10 lines)
CONTEXT_CONTENT=$(python3 -c "
import re, sys

text = open('CONTEXT.md').read()

# Strip HTML comments (<!-- ... -->) to reduce noise
text = re.sub(r'<!--.*?-->', '', text, flags=re.DOTALL)

# Collapse multiple blank lines
text = re.sub(r'\n{3,}', '\n\n', text).strip()

# Cap at 3000 chars to avoid flooding context window
print(text[:3000])
" 2>/dev/null || cat CONTEXT.md | head -80)

[ -z "$CONTEXT_CONTENT" ] && exit 0

MESSAGE=$(python3 -c "
import json, sys
content = sys.argv[1]
msg = '## Live Project Context (auto-injected from CONTEXT.md)\n\n' + content
print(json.dumps({'systemMessage': msg}))
" "$CONTEXT_CONTENT" 2>/dev/null || echo "{}")

echo "$MESSAGE"
exit 0
