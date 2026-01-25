#!/usr/bin/env bash
#
# Install mise and all tools from .tool-versions
#

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=== mise Setup ==="

# Install mise if not present
if ! command -v mise &>/dev/null; then
    echo "Installing mise..."
    if command -v brew &>/dev/null; then
        brew install mise
    else
        # Use official installer for Linux/other systems
        curl https://mise.run | sh
        # Add to PATH for this session
        export PATH="$HOME/.local/bin:$PATH"
    fi
fi

# Activate mise for this session
eval "$(mise activate bash --shims)"

# Trust the dotfiles directory
mise trust "$DOTFILES_DIR"

# GitHub auth for mise (avoids rate limits when downloading tools)
if [[ -z "$GITHUB_TOKEN" ]]; then
    if command -v gh &>/dev/null; then
        if gh auth status &>/dev/null; then
            echo "Using GitHub token from gh CLI..."
            export GITHUB_TOKEN=$(gh auth token)
        else
            echo ""
            echo "GitHub authentication recommended to avoid rate limits."
            read -p "Authenticate now? [y/N] " -n 1 -r
            echo ""
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                gh auth login
                export GITHUB_TOKEN=$(gh auth token)
            fi
        fi
    fi
fi

# Install all tools from tool-versions
echo "Installing tools from .tool-versions..."
mise install

# Set global defaults
echo "Setting global tool versions..."
cd "$DOTFILES_DIR/mise"
while IFS= read -r line; do
    # Skip comments and empty lines
    [[ "$line" =~ ^#.*$ ]] && continue
    [[ -z "$line" ]] && continue

    tool=$(echo "$line" | awk '{print $1}')
    version=$(echo "$line" | awk '{print $2}')

    if [[ -n "$tool" && -n "$version" ]]; then
        mise use -g "$tool@$version" 2>/dev/null || true
    fi
done < tool-versions

echo "✓ mise setup complete"
