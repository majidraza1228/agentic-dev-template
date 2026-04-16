#!/bin/bash
# scripts/hook-post-tool-lint.sh
# PostToolUse hook — runs the linter on any file the agent just wrote or edited.
# Only triggers on file-write tool calls (create_file, replace_string_in_file, etc.).
# Outputs a system message with lint results so the agent can self-correct.
#
# TODO: Uncomment and configure the linter block that matches your stack.

set -e

INPUT=$(cat)

# Extract the file path that was just written
FILEPATH=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    inp = d.get('tool_input') or d.get('toolInput') or {}
    # Common field names across different tools
    for key in ('filePath', 'file_path', 'path', 'target_file'):
        if inp.get(key):
            print(inp[key])
            break
except Exception:
    pass
" 2>/dev/null || echo "")

# Only proceed if we have a file path
[ -z "$FILEPATH" ] && exit 0

# Only lint source files, skip lockfiles and generated assets
if echo "$FILEPATH" | grep -qE '(package-lock\.json|yarn\.lock|poetry\.lock|\.min\.|node_modules|__pycache__|\.git/)'; then
  exit 0
fi

EXT="${FILEPATH##*.}"
LINT_OUTPUT=""
LINT_STATUS=0

# ---------------------------------------------------------------------------
# Python — ruff
# ---------------------------------------------------------------------------
if [[ "$EXT" == "py" ]]; then
  if command -v ruff &>/dev/null; then
    LINT_OUTPUT=$(ruff check "$FILEPATH" 2>&1) || LINT_STATUS=$?
  elif command -v flake8 &>/dev/null; then
    LINT_OUTPUT=$(flake8 "$FILEPATH" 2>&1) || LINT_STATUS=$?
  fi

# ---------------------------------------------------------------------------
# JavaScript / TypeScript — eslint
# ---------------------------------------------------------------------------
elif [[ "$EXT" =~ ^(js|ts|jsx|tsx|mjs|cjs)$ ]]; then
  if command -v npx &>/dev/null && [ -f ".eslintrc*" -o -f "eslint.config.*" ]; then
    LINT_OUTPUT=$(npx eslint --quiet "$FILEPATH" 2>&1) || LINT_STATUS=$?
  fi

# ---------------------------------------------------------------------------
# Shell scripts — shellcheck
# ---------------------------------------------------------------------------
elif [[ "$EXT" == "sh" ]]; then
  if command -v shellcheck &>/dev/null; then
    LINT_OUTPUT=$(shellcheck "$FILEPATH" 2>&1) || LINT_STATUS=$?
  fi

# ---------------------------------------------------------------------------
# Go — golangci-lint (single file via go vet as fallback)
# ---------------------------------------------------------------------------
elif [[ "$EXT" == "go" ]]; then
  if command -v golangci-lint &>/dev/null; then
    LINT_OUTPUT=$(golangci-lint run "$FILEPATH" 2>&1) || LINT_STATUS=$?
  elif command -v go &>/dev/null; then
    LINT_OUTPUT=$(go vet ./... 2>&1) || LINT_STATUS=$?
  fi

# ---------------------------------------------------------------------------
# TODO: Add your stack's linter here
# elif [[ "$EXT" == "rb" ]]; then
#   LINT_OUTPUT=$(rubocop "$FILEPATH" 2>&1) || LINT_STATUS=$?
# ---------------------------------------------------------------------------
fi

# If lint found issues, inject them as a system message for the agent to fix
if [ "$LINT_STATUS" -ne 0 ] && [ -n "$LINT_OUTPUT" ]; then
  MESSAGE=$(python3 -c "
import json, sys
output = sys.argv[1][:2000]  # cap to avoid huge messages
filepath = sys.argv[2]
msg = f'Lint errors found in {filepath} — fix these before continuing:\n\n{output}'
print(json.dumps({'systemMessage': msg}))
" "$LINT_OUTPUT" "$FILEPATH" 2>/dev/null || echo "{}")
  echo "$MESSAGE"
fi

exit 0
