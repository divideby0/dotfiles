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
    # Filter out comments and empty lines, then drop anything this release
    # does not carry: one unknown name makes apt-get abort the whole install
    # (zsh-completions, for one, is not packaged on Ubuntu 26.04).
    available=()
    for pkg in $(grep -v '^#' "$DOTFILES_DIR/packages/apt.txt" | grep -v '^$'); do
        if apt-cache show "$pkg" &>/dev/null; then
            available+=("$pkg")
        else
            echo "Skipping $pkg: not available in this release"
        fi
    done
    sudo apt-get install -y "${available[@]}"
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
