#!/bin/bash
# .claude/hooks/audit.sh
# Standalone audit log viewer and reporter
# Usage:
#   ./audit.sh today          — show today's audit log
#   ./audit.sh summary        — show tool call summary for today
#   ./audit.sh search "Write" — search audit log for a tool or keyword
#   ./audit.sh clean 30       — delete audit logs older than 30 days

AUDIT_DIR="$HOME/.claude/audit"
TODAY=$(date +%Y-%m-%d)
COMMAND="${1:-today}"

case "$COMMAND" in
  today)
    echo "=== Claude Audit Log: $TODAY ==="
    if [[ -f "$AUDIT_DIR/$TODAY.jsonl" ]]; then
      cat "$AUDIT_DIR/$TODAY.jsonl" | jq '.' 2>/dev/null || cat "$AUDIT_DIR/$TODAY.jsonl"
    else
      echo "No audit log for today."
    fi
    ;;

  summary)
    echo "=== Tool Call Summary: $TODAY ==="
    if [[ -f "$AUDIT_DIR/$TODAY.jsonl" ]]; then
      cat "$AUDIT_DIR/$TODAY.jsonl" | \
        jq -r '.tool' 2>/dev/null | \
        sort | uniq -c | sort -rn
    else
      echo "No audit log for today."
    fi
    ;;

  search)
    KEYWORD="${2:-}"
    echo "=== Searching audit logs for: '$KEYWORD' ==="
    grep -r "$KEYWORD" "$AUDIT_DIR/" 2>/dev/null | jq '.' 2>/dev/null || \
      grep -r "$KEYWORD" "$AUDIT_DIR/" 2>/dev/null
    ;;

  clean)
    DAYS="${2:-30}"
    echo "=== Deleting audit logs older than $DAYS days ==="
    find "$AUDIT_DIR" -name "*.jsonl" -mtime +"$DAYS" -delete
    echo "Done."
    ;;

  *)
    echo "Usage: audit.sh [today|summary|search <keyword>|clean <days>]"
    ;;
esac
