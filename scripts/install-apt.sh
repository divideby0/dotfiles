#!/usr/bin/env bash
#
# Install packages on Debian/Ubuntu using apt
#

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=== APT Package Setup ==="

# Install packages from list
if [[ -f "$DOTFILES_DIR/packages/apt.txt" ]]; then
    echo "Installing packages from apt.txt..."
    # Filter out comments and empty lines
    grep -v '^#' "$DOTFILES_DIR/packages/apt.txt" | grep -v '^$' | xargs sudo apt-get install -y
else
    echo "No apt.txt found, installing essentials..."
    sudo apt-get install -y \
        zsh \
        git \
        curl \
        wget \
        ripgrep \
        jq \
        tree \
        htop \
        tmux \
        unzip
fi

# Install starship if not present (not in apt repos)
if ! command -v starship &>/dev/null; then
    echo "Installing starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

echo "✓ APT setup complete"
