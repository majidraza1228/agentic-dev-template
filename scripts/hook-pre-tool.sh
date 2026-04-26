#!/bin/bash
# scripts/hook-pre-tool.sh
# PreToolUse lifecycle hook for Copilot agent.
# Reads the tool invocation as JSON from stdin, enforces safety policies,
# and writes a permissionDecision JSON to stdout.
#
# Policy (mirrors copilot-instructions.md "Human Approval Required" section):
#   DENY  — push/commit to protected branches, edit .github/workflows/
#   ASK   — rm -rf, git reset --hard, git push --force, delete any file
#   ALLOW — everything else (exit 0, no output)
#
# Exit codes: 0 = success (allow or decision returned), 2 = blocking error

set -e

INPUT=$(cat)

# Parse tool name and stringified input — use python3 for robust JSON handling
TOOL_NAME=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get('tool_name', '') or d.get('toolName', ''))
except Exception:
    print('')
" 2>/dev/null || echo "")

TOOL_INPUT=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    inp = d.get('tool_input') or d.get('toolInput') or {}
    print(json.dumps(inp))
except Exception:
    print('{}')
" 2>/dev/null || echo "{}")

# Extract common fields from tool input
COMMAND=$(echo "$TOOL_INPUT" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get('command', '') or d.get('cmd', ''))
except Exception:
    print('')
" 2>/dev/null || echo "")

FILEPATH=$(echo "$TOOL_INPUT" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get('path', '') or d.get('filePath', '') or d.get('file_path', ''))
except Exception:
    print('')
" 2>/dev/null || echo "")

deny() {
  echo "{\"hookSpecificOutput\":{\"hookEventName\":\"PreToolUse\",\"permissionDecision\":\"deny\",\"permissionDecisionReason\":\"$1\"}}"
  exit 0
}

ask() {
  echo "{\"hookSpecificOutput\":{\"hookEventName\":\"PreToolUse\",\"permissionDecision\":\"ask\",\"permissionDecisionReason\":\"$1\"}}"
  exit 0
}

# ---------------------------------------------------------------------------
# 1. Require confirmation for destructive git operations
# ---------------------------------------------------------------------------
if echo "$COMMAND" | grep -qE 'git (push --force|push -f|reset --hard|clean -fd)'; then
  ask "Destructive git operation requires human confirmation before proceeding."
fi

# ---------------------------------------------------------------------------
# 3. Block writes to CI/CD workflows (always require human review)
# ---------------------------------------------------------------------------
if echo "$FILEPATH" | grep -qE '\.github/workflows/'; then
  deny "Modifying .github/workflows/ requires human review. Make this change manually outside the agent session."
fi

# For shell commands referencing workflow files
if echo "$COMMAND" | grep -qE '\.github/workflows/'; then
  deny "Modifying .github/workflows/ requires human review."
fi

# ---------------------------------------------------------------------------
# 4. Require confirmation for recursive deletions
# ---------------------------------------------------------------------------
if echo "$COMMAND" | grep -qE 'rm\s+-[a-zA-Z]*r[a-zA-Z]*f|rm\s+-[a-zA-Z]*f[a-zA-Z]*r|rimraf|deltree'; then
  ask "Recursive/force delete (rm -rf) requires human confirmation."
fi

# ---------------------------------------------------------------------------
# 5. Require confirmation for direct file deletion tool calls
# ---------------------------------------------------------------------------
if [[ "$TOOL_NAME" == *"delete"* ]] || [[ "$TOOL_NAME" == *"remove"* ]]; then
  ask "File deletion via agent tools requires human approval. Please confirm you want to delete: $FILEPATH"
fi

# ---------------------------------------------------------------------------
# Allow everything else
# ---------------------------------------------------------------------------
exit 0
