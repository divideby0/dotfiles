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

# Trust the third-party taps declared in the Brewfile. brew bundle refuses
# to load formulae from untrusted taps, which breaks non-interactive
# bootstrap (`brew trust` is a per-machine setting, not stored in the repo).
echo "Trusting third-party taps..."
grep -E '^[[:space:]]*tap "' "$DOTFILES_DIR/Brewfile" \
    | sed -E 's/.*tap "([^"]+)".*/\1/' \
    | while read -r t; do
        brew tap "$t" >/dev/null 2>&1 || true
        brew trust "$t" >/dev/null 2>&1 || true
    done

# Install from Brewfile. Select what to install with HOMEBREW_PROFILE
# (personal|work|server); see the Brewfile header for group overrides.
# e.g. HOMEBREW_PROFILE=work ./bootstrap.sh
echo "Installing from Brewfile (profile: ${HOMEBREW_PROFILE:-personal})..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

echo "✓ Homebrew setup complete"
