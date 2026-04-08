#!/bin/bash
# .claude/hooks/post-tool-use.sh
# PostToolUse Hook — runs after every Claude tool call
# Handles post-write formatting, notifications, and audit logging
#
# Arguments:
#   $1 = tool name
#   $2 = tool input (JSON)
#   $3 = tool output/result (JSON)

TOOL="$1"
INPUT="$2"
OUTPUT="$3"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# ---------------------------------------------------------------------------
# 1. Auto-format after file writes (optional — uncomment your formatter)
# ---------------------------------------------------------------------------
# if [[ "$TOOL" == "Write" || "$TOOL" == "Edit" ]]; then
#   FILE_PATH=$(echo "$INPUT" | jq -r '.file_path // empty' 2>/dev/null)
#   if [[ -n "$FILE_PATH" ]]; then
#     case "$FILE_PATH" in
#       *.ts|*.tsx|*.js|*.jsx) npx prettier --write "$FILE_PATH" 2>/dev/null ;;
#       *.py) ruff format "$FILE_PATH" 2>/dev/null ;;
#       *.go) gofmt -w "$FILE_PATH" 2>/dev/null ;;
#     esac
#   fi
# fi

# ---------------------------------------------------------------------------
# 2. Notify on bash command execution (optional Slack hook)
# ---------------------------------------------------------------------------
# if [[ "$TOOL" == "Bash" ]]; then
#   COMMAND=$(echo "$INPUT" | jq -r '.command // empty' 2>/dev/null)
#   if [[ "$COMMAND" == *"git commit"* ]]; then
#     # Notify team of agent commit (requires SLACK_WEBHOOK_URL env var)
#     # curl -s -X POST "$SLACK_WEBHOOK_URL" \
#     #   -H 'Content-type: application/json' \
#     #   --data "{\"text\":\"🤖 Agent committed: $COMMAND\"}" > /dev/null
#   fi
# fi

# ---------------------------------------------------------------------------
# 3. LOG: structured audit trail
# ---------------------------------------------------------------------------
AUDIT_DIR="$HOME/.claude/audit"
mkdir -p "$AUDIT_DIR"
AUDIT_FILE="$AUDIT_DIR/$(date +%Y-%m-%d).jsonl"

LOG_ENTRY=$(jq -n \
  --arg ts "$TIMESTAMP" \
  --arg hook "PostToolUse" \
  --arg tool "$TOOL" \
  --arg input_preview "$(echo "$INPUT" | head -c 200)" \
  --arg output_preview "$(echo "$OUTPUT" | head -c 200)" \
  '{ts: $ts, hook: $hook, tool: $tool, input_preview: $input_preview, output_preview: $output_preview}' \
  2>/dev/null || echo "{\"ts\":\"$TIMESTAMP\",\"hook\":\"PostToolUse\",\"tool\":\"$TOOL\"}")

echo "$LOG_ENTRY" >> "$AUDIT_FILE"

exit 0
