#!/bin/bash
# scripts/worktree-agent.sh
# Helper script to spin up isolated git worktrees for parallel agent sessions.
# Each worktree = its own branch = its own filesystem = no conflicts between agents.
#
# Usage:
#   ./scripts/worktree-agent.sh create <agent-type> <task-description>
#   ./scripts/worktree-agent.sh list
#   ./scripts/worktree-agent.sh remove <worktree-path>
#   ./scripts/worktree-agent.sh clean       ← removes all agent worktrees
#
# Examples:
#   ./scripts/worktree-agent.sh create claude auth-refactor
#   ./scripts/worktree-agent.sh create copilot test-generation
#   ./scripts/worktree-agent.sh create codex docs-update
#   ./scripts/worktree-agent.sh list
#   ./scripts/worktree-agent.sh clean

set -e

COMMAND="${1:-help}"
REPO_ROOT=$(git rev-parse --show-toplevel)
REPO_NAME=$(basename "$REPO_ROOT")
WORKTREES_DIR="$(dirname "$REPO_ROOT")/${REPO_NAME}-worktrees"
BASE_BRANCH="${BASE_BRANCH:-develop}"

case "$COMMAND" in

  # -------------------------------------------------------------------------
  create)
    AGENT_TYPE="${2:-agent}"
    TASK_DESC="${3:-task}"
    TIMESTAMP=$(date +%Y%m%d-%H%M)

    # Validate agent type
    if [[ ! "$AGENT_TYPE" =~ ^(claude|copilot|codex|agent)$ ]]; then
      echo "❌ Unknown agent type: $AGENT_TYPE"
      echo "   Valid types: claude, copilot, codex, agent"
      exit 1
    fi

    BRANCH_NAME="${AGENT_TYPE}/${TASK_DESC}"
    WORKTREE_PATH="${WORKTREES_DIR}/${AGENT_TYPE}-${TASK_DESC}-${TIMESTAMP}"

    echo "🌿 Creating worktree for $AGENT_TYPE agent..."
    echo "   Branch:   $BRANCH_NAME"
    echo "   Path:     $WORKTREE_PATH"
    echo "   Base:     $BASE_BRANCH"
    echo ""

    # Ensure worktrees directory exists
    mkdir -p "$WORKTREES_DIR"

    # Fetch latest base branch
    git fetch origin "$BASE_BRANCH" --quiet 2>/dev/null || echo "⚠️  Could not fetch from remote (offline?)"

    # Create the worktree on a new branch
    git worktree add -b "$BRANCH_NAME" "$WORKTREE_PATH" "origin/$BASE_BRANCH" 2>/dev/null || \
    git worktree add -b "$BRANCH_NAME" "$WORKTREE_PATH" "$BASE_BRANCH"

    echo ""
    echo "✅ Worktree created!"
    echo ""
    echo "Next steps:"
    echo "  1. Open this folder in your editor:"
    echo "     code \"$WORKTREE_PATH\""
    echo ""
    echo "  2. Run pre-task check:"
    echo "     cd \"$WORKTREE_PATH\" && bash scripts/pre-task.sh"
    echo ""
    echo "  3. Start your $AGENT_TYPE agent in this folder"
    echo ""
    echo "  4. When done, run post-task check:"
    echo "     bash scripts/post-task.sh"
    echo ""
    echo "  5. Push and open Draft PR:"
    echo "     git push origin $BRANCH_NAME"
    ;;

  # -------------------------------------------------------------------------
  list)
    echo "🌿 Active agent worktrees:"
    echo ""
    git worktree list
    ;;

  # -------------------------------------------------------------------------
  remove)
    WORKTREE_PATH="${2:-}"
    if [ -z "$WORKTREE_PATH" ]; then
      echo "❌ Please provide the worktree path to remove."
      echo "   Usage: ./scripts/worktree-agent.sh remove <path>"
      exit 1
    fi

    echo "🗑️  Removing worktree: $WORKTREE_PATH"
    git worktree remove "$WORKTREE_PATH" --force
    echo "✅ Worktree removed."
    ;;

  # -------------------------------------------------------------------------
  clean)
    echo "🧹 Removing all agent worktrees from: $WORKTREES_DIR"
    echo ""

    if [ ! -d "$WORKTREES_DIR" ]; then
      echo "No agent worktrees directory found."
      exit 0
    fi

    # List what will be removed
    git worktree list | grep "$WORKTREES_DIR" || echo "No agent worktrees found."

    read -p "Remove all agent worktrees? (y/N) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      while IFS= read -r line; do
        PATH_TO_REMOVE=$(echo "$line" | awk '{print $1}')
        if [[ "$PATH_TO_REMOVE" == "$WORKTREES_DIR"* ]]; then
          echo "  Removing: $PATH_TO_REMOVE"
          git worktree remove "$PATH_TO_REMOVE" --force 2>/dev/null || true
        fi
      done < <(git worktree list)
      echo "✅ All agent worktrees removed."
    else
      echo "Cancelled."
    fi
    ;;

  # -------------------------------------------------------------------------
  help|*)
    echo "Usage: worktree-agent.sh <command> [args]"
    echo ""
    echo "Commands:"
    echo "  create <agent-type> <task-description>"
    echo "       Creates a new isolated worktree for a parallel agent session."
    echo "       Agent types: claude, copilot, codex, agent"
    echo "       Example: ./scripts/worktree-agent.sh create claude auth-refactor"
    echo ""
    echo "  list"
    echo "       Lists all active worktrees."
    echo ""
    echo "  remove <path>"
    echo "       Removes a specific worktree."
    echo ""
    echo "  clean"
    echo "       Removes all agent worktrees (with confirmation)."
    ;;

esac
