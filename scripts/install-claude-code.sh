#!/usr/bin/env bash
#
# Install Claude Code CLI
#

set -e

echo "=== Claude Code Setup ==="

if command -v claude &>/dev/null; then
    echo "Claude Code already installed: $(claude --version)"
else
    echo "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
fi

echo "✓ Claude Code setup complete"
