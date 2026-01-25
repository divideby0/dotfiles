#!/usr/bin/env bash
#
# Bootstrap a fresh macOS or Linux installation
#
# Usage:
#   git clone https://github.com/divideby0/dotfiles.git ~/dotfiles
#   cd ~/dotfiles
#   ./bootstrap.sh
#

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source OS detection
source "$DOTFILES_DIR/scripts/lib/detect-os.sh"

OS=$(detect_os)
ARCH=$(detect_arch)

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
echo "  Dotfiles Bootstrap"
echo "=========================================="
echo ""
info "Dotfiles directory: $DOTFILES_DIR"
info "Detected OS: $OS ($ARCH)"
echo ""

# =============================================================================
# Pre-flight checks (OS-specific)
# =============================================================================

if [[ "$OS" == "macos" ]]; then
    # Check for Xcode Command Line Tools
    if ! xcode-select -p &>/dev/null; then
        info "Installing Xcode Command Line Tools..."
        xcode-select --install
        echo "Please complete the Xcode CLI tools installation and re-run this script."
        exit 0
    fi
    success "Xcode Command Line Tools installed"

    # Install Rosetta on Apple Silicon
    if [[ "$ARCH" == "arm64" ]]; then
        if ! /usr/bin/pgrep oahd &>/dev/null; then
            info "Installing Rosetta..."
            /usr/sbin/softwareupdate --install-rosetta --agree-to-license
        fi
        success "Rosetta installed"
    fi
elif [[ "$OS" == "debian" ]]; then
    info "Updating apt package lists..."
    sudo apt-get update
elif [[ "$OS" == "redhat" ]]; then
    info "Updating yum package lists..."
    sudo yum check-update || true
fi

# =============================================================================
# Make scripts executable
# =============================================================================
chmod +x "$DOTFILES_DIR/scripts/"*.sh 2>/dev/null || true
chmod +x "$DOTFILES_DIR/scripts/lib/"*.sh 2>/dev/null || true
chmod +x "$DOTFILES_DIR/install.sh"

# =============================================================================
# Run installation scripts in order
# =============================================================================

# Step 1: Package manager setup
info "Step 1/6: Installing system packages..."
if [[ "$OS" == "macos" ]]; then
    "$DOTFILES_DIR/scripts/install-homebrew.sh"
elif [[ "$OS" == "debian" ]]; then
    "$DOTFILES_DIR/scripts/install-apt.sh"
elif [[ "$OS" == "redhat" ]]; then
    "$DOTFILES_DIR/scripts/install-yum.sh"
elif [[ "$OS" == "synology" ]]; then
    warn "Synology detected - skipping system packages (limited support)"
else
    warn "Unknown OS - skipping system packages"
fi
echo ""

# Step 2: Oh My Zsh
info "Step 2/6: Installing Oh My Zsh..."
"$DOTFILES_DIR/scripts/install-oh-my-zsh.sh"
echo ""

# Step 3: Symlinks
info "Step 3/6: Creating symlinks..."
"$DOTFILES_DIR/install.sh"
echo ""

# Step 4: mise
info "Step 4/6: Installing mise and tools..."
"$DOTFILES_DIR/scripts/install-mise.sh"
echo ""

# Step 5: uv tools (Python)
info "Step 5/6: Installing uv tools..."
"$DOTFILES_DIR/scripts/install-uv-tools.sh"
echo ""

# Step 6: Claude Code (optional, skip on servers)
if [[ "$OS" == "macos" ]] || [[ -n "$INSTALL_CLAUDE" ]]; then
    info "Step 6/6: Installing Claude Code..."
    "$DOTFILES_DIR/scripts/install-claude-code.sh"
else
    info "Step 6/6: Skipping Claude Code (set INSTALL_CLAUDE=1 to install)"
fi
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
