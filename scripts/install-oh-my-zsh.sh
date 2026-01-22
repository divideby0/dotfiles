#!/usr/bin/env bash
#
# Install Oh My Zsh
#

set -e

echo "=== Oh My Zsh Setup ==="

if [[ -d "$HOME/.oh-my-zsh" ]]; then
    echo "Oh My Zsh already installed"
else
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "✓ Oh My Zsh setup complete"
