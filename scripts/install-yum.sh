#!/usr/bin/env bash
#
# Install packages on RHEL/Amazon Linux/CentOS using yum
#

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=== YUM Package Setup ==="

# Install packages from list
if [[ -f "$DOTFILES_DIR/packages/yum.txt" ]]; then
    echo "Installing packages from yum.txt..."
    # Filter out comments and empty lines
    grep -v '^#' "$DOTFILES_DIR/packages/yum.txt" | grep -v '^$' | xargs sudo yum install -y
else
    echo "No yum.txt found, installing essentials..."
    sudo yum install -y \
        zsh \
        git \
        curl \
        wget \
        jq \
        tree \
        htop \
        tmux \
        unzip
fi

# Install starship if not present
if ! command -v starship &>/dev/null; then
    echo "Installing starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

echo "✓ YUM setup complete"
