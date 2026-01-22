#!/usr/bin/env bash
#
# Install mise and all tools from .tool-versions
#

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=== mise Setup ==="

# Install mise if not present
if ! command -v mise &>/dev/null; then
    echo "Installing mise..."
    brew install mise
fi

# Activate mise for this session
eval "$(mise activate bash --shims)"

# Trust the dotfiles directory
mise trust "$DOTFILES_DIR"

# Install all tools from tool-versions
echo "Installing tools from .tool-versions..."
mise install

# Set global defaults
echo "Setting global tool versions..."
cd "$DOTFILES_DIR/mise"
while IFS= read -r line; do
    # Skip comments and empty lines
    [[ "$line" =~ ^#.*$ ]] && continue
    [[ -z "$line" ]] && continue

    tool=$(echo "$line" | awk '{print $1}')
    version=$(echo "$line" | awk '{print $2}')

    if [[ -n "$tool" && -n "$version" ]]; then
        mise use -g "$tool@$version" 2>/dev/null || true
    fi
done < tool-versions

echo "✓ mise setup complete"
