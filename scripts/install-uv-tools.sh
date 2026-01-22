#!/usr/bin/env bash
#
# Install Python tools via uv (pipx replacement)
#

set -e

echo "=== uv Tools Setup ==="

# Ensure uv is available (installed via mise)
if ! command -v uv &>/dev/null; then
    echo "ERROR: uv not found. Run install-mise.sh first."
    exit 1
fi

# Install ansible-core
echo "Installing ansible-core..."
uv tool install ansible-core

# Add other Python CLI tools here as needed
# uv tool install <package>

echo "✓ uv tools setup complete"
