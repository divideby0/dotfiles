#!/usr/bin/env bash
#
# Install packages on Synology DSM using Entware (opkg)
#

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OPKG=/opt/bin/opkg

echo "=== Entware Package Setup ==="

if [[ ! -x "$OPKG" ]]; then
    echo "Entware not found at /opt. Install it first:"
    echo "  https://github.com/Entware/Entware/wiki/Install-on-Synology-NAS"
    exit 1
fi

sudo "$OPKG" update
sudo "$OPKG" upgrade

grep -v '^#' "$DOTFILES_DIR/packages/entware.txt" | grep -v '^$' | xargs sudo "$OPKG" install

echo "✓ Entware setup complete"
