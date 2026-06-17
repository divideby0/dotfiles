#!/usr/bin/env bash
#
# Install Homebrew and run brew bundle
#

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=== Homebrew Setup ==="

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add to path for this session
    if [[ "$(uname -m)" == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "Homebrew already installed"
fi

# Update Homebrew
echo "Updating Homebrew..."
brew update

# Install from Brewfile. Select what to install with HOMEBREW_PROFILE
# (personal|work|server); see the Brewfile header for group overrides.
# e.g. HOMEBREW_PROFILE=work ./bootstrap.sh
echo "Installing from Brewfile (profile: ${HOMEBREW_PROFILE:-personal})..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

echo "✓ Homebrew setup complete"
