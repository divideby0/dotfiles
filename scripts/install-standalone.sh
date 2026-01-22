#!/usr/bin/env bash
#
# Install standalone tools (curl-based installs not from brew/mise/uv)
#

set -e

echo "=== Standalone Tools Setup ==="

# Claude Code CLI
if command -v claude &>/dev/null; then
    echo "Claude Code already installed: $(claude --version)"
else
    echo "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
fi

# Add more standalone installs here as needed:
# if ! command -v foo &>/dev/null; then
#     echo "Installing foo..."
#     curl -fsSL https://example.com/install.sh | bash
# fi

echo "✓ Standalone tools setup complete"
