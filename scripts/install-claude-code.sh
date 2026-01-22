#!/usr/bin/env bash
#
# Install and configure Claude Code
#

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

echo "=== Claude Code Setup ==="

# Install Claude Code CLI
if command -v claude &>/dev/null; then
    echo "Claude Code already installed: $(claude --version)"
else
    echo "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
fi

# Merge settings.json (can't symlink - user file contains secrets)
CLAUDE_SETTINGS="$HOME/.claude/settings.json"
DOTFILES_CLAUDE_SETTINGS="$DOTFILES_DIR/claude/settings.json"

if [[ -f "$DOTFILES_CLAUDE_SETTINGS" ]]; then
    if command -v jq &>/dev/null; then
        if [[ -f "$CLAUDE_SETTINGS" ]]; then
            # Merge dotfiles settings into existing (dotfiles values override)
            MERGED=$(jq -s '.[0] * .[1]' "$CLAUDE_SETTINGS" "$DOTFILES_CLAUDE_SETTINGS")
            echo "$MERGED" > "$CLAUDE_SETTINGS"
            success "Merged Claude Code settings from dotfiles"
        else
            # No existing settings, just copy
            mkdir -p "$HOME/.claude"
            cp "$DOTFILES_CLAUDE_SETTINGS" "$CLAUDE_SETTINGS"
            success "Created Claude Code settings from dotfiles"
        fi
    else
        warn "jq not found - manually merge $DOTFILES_CLAUDE_SETTINGS into $CLAUDE_SETTINGS"
    fi
fi

# Symlink ccstatusline config
CCSTATUSLINE_SRC="$DOTFILES_DIR/config/ccstatusline/settings.json"
CCSTATUSLINE_DST="$HOME/.config/ccstatusline/settings.json"

if [[ -f "$CCSTATUSLINE_SRC" ]]; then
    mkdir -p "$HOME/.config/ccstatusline"
    if [[ -L "$CCSTATUSLINE_DST" ]]; then
        rm "$CCSTATUSLINE_DST"
    elif [[ -f "$CCSTATUSLINE_DST" ]]; then
        mv "$CCSTATUSLINE_DST" "$CCSTATUSLINE_DST.bak"
    fi
    ln -s "$CCSTATUSLINE_SRC" "$CCSTATUSLINE_DST"
    success "Linked ccstatusline config"
fi

echo "✓ Claude Code setup complete"
