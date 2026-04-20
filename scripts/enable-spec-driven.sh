#!/usr/bin/env bash
set -euo pipefail

echo "Enabling Spec-Driven Development (Spec Kit) in this repository..."

if ! command -v uvx >/dev/null 2>&1; then
  echo "uvx not found. Install uv first: https://docs.astral.sh/uv/"
  exit 1
fi

uvx --from git+https://github.com/github/spec-kit.git specify init --here

echo ""
echo "Spec Kit initialized."
echo "Next: run /speckit.constitution, /speckit.specify, /speckit.plan, /speckit.tasks, /speckit.implement"
