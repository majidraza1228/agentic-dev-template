#!/bin/bash
# .devcontainer/scripts/post-create.sh
# Runs ONCE when the devcontainer is first created.
# Use this for one-time setup: installing dependencies, setting up DB, etc.

set -e
echo "🔧 Running post-create setup..."

# ---------------------------------------------------------------------------
# TODO: Uncomment and customize for your stack
# ---------------------------------------------------------------------------

# Node.js
# echo "📦 Installing Node dependencies..."
# npm install

# Python
# echo "🐍 Installing Python dependencies..."
# pip install -r requirements.txt --quiet

# Go
# echo "🐹 Installing Go dependencies..."
# go mod download

# Database setup
# echo "🗄️  Running database migrations..."
# [your migration command]

# Make scripts executable
chmod +x scripts/pre-task.sh scripts/post-task.sh scripts/worktree-agent.sh 2>/dev/null || true
chmod +x .claude/hooks/pre-tool-use.sh .claude/hooks/post-tool-use.sh .claude/hooks/audit.sh 2>/dev/null || true

echo "✅ Post-create setup complete."
