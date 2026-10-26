#!/usr/bin/env bash
#
# Install packages on Arch Linux and derivatives (Omarchy) using pacman
#

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=== pacman Package Setup ==="

# No `pacman -Sy` here: refreshing the sync database without a full upgrade
# is a partial upgrade, which Arch does not support. Packages install from
# the database as it stands; if a download 404s, run a full system upgrade
# first (`sudo pacman -Syu`, or `omarchy update` on Omarchy) and re-run.
if [[ -f "$DOTFILES_DIR/packages/pacman.txt" ]]; then
    echo "Installing packages from pacman.txt..."
    # Skip names the configured repositories do not carry, so one unknown
    # name cannot abort the whole install. Groups (base-devel) count.
    available=()
    for pkg in $(grep -v '^#' "$DOTFILES_DIR/packages/pacman.txt" | grep -v '^$'); do
        if pacman -Si "$pkg" &>/dev/null || pacman -Sg "$pkg" &>/dev/null; then
            available+=("$pkg")
        else
            echo "Skipping $pkg: not in the configured repositories"
        fi
    done
    sudo pacman -S --needed --noconfirm "${available[@]}"
else
    echo "No pacman.txt found, installing essentials..."
    sudo pacman -S --needed --noconfirm zsh git curl wget ripgrep jq tree htop tmux unzip
fi

# starship is in the Arch repositories; Omarchy ships it already
if ! command -v starship &>/dev/null; then
    sudo pacman -S --needed --noconfirm starship
fi

echo "✓ pacman setup complete"
