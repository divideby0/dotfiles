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

# Install the global tool set. The [tools] table in mise/config.toml, which
# install.sh links as ~/.config/mise/config.toml, already IS the set of
# global defaults — no `mise use -g` pass is needed. (One used to re-pin every
# line of tool-versions here, and because the global config is a symlink
# into this repo, it rewrote config.toml with tool-versions' older pins.)
echo "Installing mise tools..."
mise install

echo "✓ mise setup complete"
