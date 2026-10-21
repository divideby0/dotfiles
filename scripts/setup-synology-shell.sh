#!/usr/bin/env bash
#
# Make zsh the interactive login shell on Synology DSM
#
# DSM has no chsh and rewrites /etc/passwd on updates, so instead of changing
# the login shell we exec Entware's zsh from ~/.profile for interactive logins.
# Non-interactive sessions (scp, sftp, `ssh host cmd`, rsync) are untouched.
#

set -e

ZSH_BIN=/opt/bin/zsh
PROFILE="$HOME/.profile"
MARKER="# dotfiles: hand interactive logins to zsh"

echo "=== Synology Shell Setup ==="

if [[ ! -x "$ZSH_BIN" ]]; then
    echo "zsh not found at $ZSH_BIN - run install-entware.sh first"
    exit 1
fi

if grep -qF "$MARKER" "$PROFILE" 2>/dev/null; then
    echo "~/.profile already hands off to zsh"
else
    cat >> "$PROFILE" <<EOF

$MARKER (DSM resets /etc/passwd shells)
case \$- in
    *i*) [ -x $ZSH_BIN ] && [ -z "\$ZSH_VERSION" ] && SHELL=$ZSH_BIN exec $ZSH_BIN -l ;;
esac
EOF
    echo "Added zsh handoff to ~/.profile"
fi

echo "✓ Synology shell setup complete"
