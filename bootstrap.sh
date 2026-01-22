#!/usr/bin/env bash
#
# Bootstrap a fresh macOS installation
#
# Usage:
#   git clone https://github.com/divideby0/dotfiles.git ~/src/divideby0/dotfiles
#   cd ~/src/divideby0/dotfiles
#   ./bootstrap.sh
#

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

echo ""
echo "=========================================="
echo "  macOS Dotfiles Bootstrap"
echo "=========================================="
echo ""
info "Dotfiles directory: $DOTFILES_DIR"
echo ""

# =============================================================================
# Pre-flight checks
# =============================================================================

# Check for Xcode Command Line Tools
if ! xcode-select -p &>/dev/null; then
    info "Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "Please complete the Xcode CLI tools installation and re-run this script."
    exit 0
fi
success "Xcode Command Line Tools installed"

# Install Rosetta on Apple Silicon
if [[ "$(uname -m)" == "arm64" ]]; then
    if ! /usr/bin/pgrep oahd &>/dev/null; then
        info "Installing Rosetta..."
        /usr/sbin/softwareupdate --install-rosetta --agree-to-license
    fi
    success "Rosetta installed"
fi

# =============================================================================
# Make scripts executable
# =============================================================================
chmod +x "$DOTFILES_DIR/scripts/"*.sh
chmod +x "$DOTFILES_DIR/install.sh"

# =============================================================================
# Run installation scripts in order
# =============================================================================

info "Step 1/6: Installing Homebrew and packages..."
"$DOTFILES_DIR/scripts/install-homebrew.sh"
echo ""

info "Step 2/6: Installing Oh My Zsh..."
"$DOTFILES_DIR/scripts/install-oh-my-zsh.sh"
echo ""

info "Step 3/6: Creating symlinks..."
"$DOTFILES_DIR/install.sh"
echo ""

info "Step 4/6: Installing mise and tools..."
"$DOTFILES_DIR/scripts/install-mise.sh"
echo ""

info "Step 5/6: Installing uv tools..."
"$DOTFILES_DIR/scripts/install-uv-tools.sh"
echo ""

info "Step 6/6: Installing standalone tools..."
"$DOTFILES_DIR/scripts/install-standalone.sh"
echo ""

# =============================================================================
# Post-install
# =============================================================================

echo ""
echo "=========================================="
echo "  Bootstrap Complete!"
echo "=========================================="
echo ""
info "Next steps:"
echo "  1. Restart your terminal (or run: exec zsh)"
echo "  2. Create ~/.gitconfig.local with your user info:"
echo "       [user]"
echo "           name = Your Name"
echo "           email = your@email.com"
echo "  3. Create ~/.zshrc.local for machine-specific settings"
echo ""
success "Done!"
