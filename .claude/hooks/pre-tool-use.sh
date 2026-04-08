#!/bin/bash
# .claude/hooks/pre-tool-use.sh
# PreToolUse Hook — runs before every Claude tool call
# Blocks dangerous operations and enforces guardrails
#
# Arguments passed by Claude Code:
#   $1 = tool name (e.g. "Bash", "Write", "Edit")
#   $2 = tool input (JSON string)

TOOL="$1"
INPUT="$2"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# ---------------------------------------------------------------------------
# 1. BLOCK: writes to protected paths
# ---------------------------------------------------------------------------
PROTECTED_PATTERNS=(
  ".github/workflows"
  "alembic/versions"
  "migrations/"
  "app/core/security"
  "src/auth/security"
)

if [[ "$TOOL" == "Write" || "$TOOL" == "Edit" ]]; then
  for pattern in "${PROTECTED_PATTERNS[@]}"; do
    if echo "$INPUT" | grep -q "$pattern"; then
      echo "BLOCK [pre-tool-use]: Write to protected path '$pattern' requires human review."
      echo "  Tool: $TOOL"
      echo "  Input snippet: $(echo "$INPUT" | head -c 200)"
      exit 1
    fi
  done
fi

# ---------------------------------------------------------------------------
# 2. BLOCK: reads/writes to secret files
# ---------------------------------------------------------------------------
SECRET_PATTERNS=(
  "\.env"
  "\.pem"
  "\.key"
  "\.p12"
  "id_rsa"
  "id_ed25519"
  "\.ssh/"
)

for pattern in "${SECRET_PATTERNS[@]}"; do
  if echo "$INPUT" | grep -qE "$pattern"; then
    echo "BLOCK [pre-tool-use]: Access to secret/credential file denied."
    echo "  Pattern matched: $pattern"
    exit 1
  fi
done

# ---------------------------------------------------------------------------
# 3. BLOCK: dangerous bash commands
# ---------------------------------------------------------------------------
BLOCKED_COMMANDS=(
  "git push.*main"
  "git push.*master"
  "git push.*--force"
  "rm -rf /"
  "chmod 777"
  "sudo rm"
  "DROP TABLE"
  "DROP DATABASE"
)

if [[ "$TOOL" == "Bash" ]]; then
  for pattern in "${BLOCKED_COMMANDS[@]}"; do
    if echo "$INPUT" | grep -qiE "$pattern"; then
      echo "BLOCK [pre-tool-use]: Dangerous command pattern '$pattern' is not allowed."
      exit 1
    fi
  done
fi

# ---------------------------------------------------------------------------
# 4. LOG: all tool calls to audit log
# ---------------------------------------------------------------------------
AUDIT_DIR="$HOME/.claude/audit"
mkdir -p "$AUDIT_DIR"
AUDIT_FILE="$AUDIT_DIR/$(date +%Y-%m-%d).jsonl"

echo "{\"ts\":\"$TIMESTAMP\",\"hook\":\"PreToolUse\",\"tool\":\"$TOOL\",\"input_preview\":$(echo "$INPUT" | head -c 200 | jq -Rs .)}" >> "$AUDIT_FILE" 2>/dev/null || true

exit 0
