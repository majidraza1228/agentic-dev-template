#!/bin/bash
# scripts/hook-post-tool-test.sh
# PostToolUse hook — runs tests related to the file the agent just wrote or edited.
# Detects corresponding test files using common naming conventions.
# Injects failures as a system message so the agent self-corrects immediately.
#
# TODO: Uncomment and configure the test runner block that matches your stack.

set -e

INPUT=$(cat)

# Extract the file path that was just written
FILEPATH=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    inp = d.get('tool_input') or d.get('toolInput') or {}
    for key in ('filePath', 'file_path', 'path', 'target_file'):
        if inp.get(key):
            print(inp[key])
            break
except Exception:
    pass
" 2>/dev/null || echo "")

[ -z "$FILEPATH" ] && exit 0

# Skip test files themselves, lockfiles, config, assets
if echo "$FILEPATH" | grep -qE '(\.test\.|\.spec\.|_test\.|tests?/|__tests__|node_modules|__pycache__|\.git/|package-lock|yarn\.lock|poetry\.lock|\.min\.|dist/|build/)'; then
  exit 0
fi

EXT="${FILEPATH##*.}"
BASENAME=$(basename "$FILEPATH" ".$EXT")
DIRPATH=$(dirname "$FILEPATH")

TEST_OUTPUT=""
TEST_STATUS=0
TEST_FILE_FOUND=false

# ---------------------------------------------------------------------------
# Python — pytest
# ---------------------------------------------------------------------------
if [[ "$EXT" == "py" ]] && command -v python3 &>/dev/null; then
  # Look for matching test file: tests/test_foo.py or tests/foo/test_foo.py
  POSSIBLE_TESTS=(
    "tests/test_${BASENAME}.py"
    "tests/${DIRPATH}/test_${BASENAME}.py"
    "${DIRPATH}/test_${BASENAME}.py"
    "test_${BASENAME}.py"
  )
  for T in "${POSSIBLE_TESTS[@]}"; do
    if [ -f "$T" ]; then
      TEST_FILE_FOUND=true
      TEST_OUTPUT=$(python3 -m pytest "$T" -q --tb=short 2>&1) || TEST_STATUS=$?
      break
    fi
  done
  # Fallback: run all tests if no specific file found
  # Uncomment to enable full suite on every write (slower):
  # if [ "$TEST_FILE_FOUND" = false ] && [ -d "tests" ]; then
  #   TEST_OUTPUT=$(python3 -m pytest tests/ -q --tb=short 2>&1) || TEST_STATUS=$?
  # fi

# ---------------------------------------------------------------------------
# JavaScript / TypeScript — jest / vitest
# ---------------------------------------------------------------------------
elif [[ "$EXT" =~ ^(js|ts|jsx|tsx|mjs)$ ]] && command -v npx &>/dev/null; then
  POSSIBLE_TESTS=(
    "${DIRPATH}/__tests__/${BASENAME}.test.${EXT}"
    "${DIRPATH}/${BASENAME}.test.${EXT}"
    "${DIRPATH}/${BASENAME}.spec.${EXT}"
    "tests/${BASENAME}.test.${EXT}"
  )
  for T in "${POSSIBLE_TESTS[@]}"; do
    if [ -f "$T" ]; then
      TEST_FILE_FOUND=true
      if [ -f "vitest.config.*" ] || grep -q '"vitest"' package.json 2>/dev/null; then
        TEST_OUTPUT=$(npx vitest run "$T" 2>&1) || TEST_STATUS=$?
      else
        TEST_OUTPUT=$(npx jest "$T" --passWithNoTests 2>&1) || TEST_STATUS=$?
      fi
      break
    fi
  done

# ---------------------------------------------------------------------------
# Go — go test
# ---------------------------------------------------------------------------
elif [[ "$EXT" == "go" ]] && command -v go &>/dev/null; then
  PKG_DIR=$(dirname "$FILEPATH")
  TEST_OUTPUT=$(go test "./${PKG_DIR}/..." 2>&1) || TEST_STATUS=$?
  TEST_FILE_FOUND=true

# ---------------------------------------------------------------------------
# TODO: Add your stack's test runner here
# elif [[ "$EXT" == "rb" ]]; then
#   TEST_OUTPUT=$(bundle exec rspec "spec/${BASENAME}_spec.rb" 2>&1) || TEST_STATUS=$?
# ---------------------------------------------------------------------------
fi

# Inject failures as a system message
if [ "$TEST_STATUS" -ne 0 ] && [ -n "$TEST_OUTPUT" ]; then
  MESSAGE=$(python3 -c "
import json, sys
output = sys.argv[1][:3000]
filepath = sys.argv[2]
msg = f'Tests failed after editing {filepath} — fix the failures before moving on:\n\n{output}'
print(json.dumps({'systemMessage': msg}))
" "$TEST_OUTPUT" "$FILEPATH" 2>/dev/null || echo "{}")
  echo "$MESSAGE"
fi

exit 0
