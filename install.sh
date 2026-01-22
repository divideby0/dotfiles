#!/usr/bin/env bash
#
# Dotfiles installer
# Creates symlinks from home directory to dotfiles in this repo
#

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Backup existing file if it exists and is not a symlink
backup_if_exists() {
    local target="$1"
    if [[ -e "$target" && ! -L "$target" ]]; then
        mkdir -p "$BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/"
        warn "Backed up existing $target to $BACKUP_DIR/"
    elif [[ -L "$target" ]]; then
        rm "$target"
    fi
}

# Create symlink
link_file() {
    local src="$1"
    local dst="$2"

    backup_if_exists "$dst"

    # Create parent directory if needed
    mkdir -p "$(dirname "$dst")"

    ln -s "$src" "$dst"
    success "Linked $dst -> $src"
}

echo ""
echo "=========================================="
echo "  Dotfiles Installer"
echo "=========================================="
echo ""
info "Dotfiles directory: $DOTFILES_DIR"
echo ""

# =============================================================================
# Shell configuration
# =============================================================================
info "Installing shell configuration..."

link_file "$DOTFILES_DIR/shell/zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/shell/zshenv" "$HOME/.zshenv"
link_file "$DOTFILES_DIR/shell/zprofile" "$HOME/.zprofile"

# =============================================================================
# Git configuration
# =============================================================================
info "Installing Git configuration..."

link_file "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/git/gitignore_global" "$HOME/.gitignore_global"

# =============================================================================
# Starship prompt
# =============================================================================
info "Installing Starship configuration..."

mkdir -p "$HOME/.config"
link_file "$DOTFILES_DIR/config/starship.toml" "$HOME/.config/starship.toml"

# gh (GitHub CLI)
mkdir -p "$HOME/.config/gh"
link_file "$DOTFILES_DIR/config/gh/config.yml" "$HOME/.config/gh/config.yml"

# zellij (terminal multiplexer)
mkdir -p "$HOME/.config/zellij"
link_file "$DOTFILES_DIR/config/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"
link_file "$DOTFILES_DIR/config/zellij/plugins" "$HOME/.config/zellij/plugins"
link_file "$DOTFILES_DIR/config/zellij/scripts" "$HOME/.config/zellij/scripts"
link_file "$DOTFILES_DIR/config/zellij/layouts" "$HOME/.config/zellij/layouts"

# =============================================================================
# Oh My Zsh custom plugins
# =============================================================================
info "Installing Oh My Zsh custom plugins..."

if [[ -d "$HOME/.oh-my-zsh" ]]; then
    mkdir -p "$HOME/.oh-my-zsh/custom/plugins"
    link_file "$DOTFILES_DIR/oh-my-zsh-custom/plugins/custom-set-path" "$HOME/.oh-my-zsh/custom/plugins/custom-set-path"
else
    warn "Oh My Zsh not found. Install it first: https://ohmyz.sh"
fi

# =============================================================================
# mise configuration
# =============================================================================
info "Installing mise configuration..."

mkdir -p "$HOME/.config/mise"
link_file "$DOTFILES_DIR/mise/config.toml" "$HOME/.config/mise/config.toml"
link_file "$DOTFILES_DIR/mise/tool-versions" "$HOME/.tool-versions"

# =============================================================================
# Misc configuration
# =============================================================================
info "Installing miscellaneous configuration..."

link_file "$DOTFILES_DIR/misc/screenrc" "$HOME/.screenrc"

# =============================================================================
# Claude Code configuration (CLAUDE.md only - settings handled by install-standalone.sh)
# =============================================================================
info "Installing Claude Code configuration..."

mkdir -p "$HOME/.claude"
link_file "$DOTFILES_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"

# =============================================================================
# Editor configuration (Cursor + VSCode)
# =============================================================================
info "Installing editor configuration..."

# Cursor
CURSOR_USER_DIR="$HOME/Library/Application Support/Cursor/User"
if [[ -d "$CURSOR_USER_DIR" ]]; then
    link_file "$DOTFILES_DIR/editors/settings.json" "$CURSOR_USER_DIR/settings.json"
else
    warn "Cursor not found at $CURSOR_USER_DIR"
fi

# VSCode (shares same settings)
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
if [[ -d "$VSCODE_USER_DIR" ]]; then
    link_file "$DOTFILES_DIR/editors/settings.json" "$VSCODE_USER_DIR/settings.json"
else
    warn "VSCode not found at $VSCODE_USER_DIR"
fi

# =============================================================================
# Post-install checks
# =============================================================================
echo ""
echo "=========================================="
echo "  Post-Install Checks"
echo "=========================================="
echo ""

# Check for required tools
check_tool() {
    if command -v "$1" &> /dev/null; then
        success "$1 is installed"
    else
        warn "$1 is not installed - $2"
    fi
}

check_tool "brew" "Install from https://brew.sh"
check_tool "starship" "Install with: brew install starship"
check_tool "mise" "Install with: brew install mise"

# Check if local config files should be created
if [[ ! -f "$HOME/.gitconfig.local" ]]; then
    echo ""
    warn "Create ~/.gitconfig.local with your user info:"
    echo "    [user]"
    echo "        name = Your Name"
    echo "        email = your@email.com"
fi

if [[ ! -f "$HOME/.zshrc.local" ]]; then
    echo ""
    info "Create ~/.zshrc.local for machine-specific aliases and settings"
fi

echo ""
echo "=========================================="
echo "  Installation Complete!"
echo "=========================================="
echo ""
info "Restart your terminal or run: source ~/.zshrc"
echo ""
