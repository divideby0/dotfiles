#!/usr/bin/env bash
#
# Enable Touch ID authentication for sudo (macOS)
#
# Configures /etc/pam.d/sudo_local (the Apple-sanctioned drop-in that
# survives OS updates) and installs pam_reattach so Touch ID also works
# inside tmux/zellij/screen. Self-skips where biometrics are unavailable
# (non-macOS, remote/SSH sessions, or Macs without a Touch ID sensor).
#

set -e

echo "=== Touch ID for sudo ==="

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "Not macOS - skipping"
    exit 0
fi

# Remote sessions have no fingerprint reader; Touch ID would just fail.
if [[ -n "$SSH_CONNECTION" || -n "$SSH_TTY" ]]; then
    echo "Remote session detected - Touch ID unavailable, skipping"
    exit 0
fi

# Bail out on Macs with no biometric hardware (e.g. most desktops).
if ! ioreg -c AppleBiometricSensor 2>/dev/null | grep -q AppleBiometricSensor; then
    echo "No Touch ID sensor found - skipping"
    exit 0
fi

if ! command -v brew &>/dev/null; then
    echo "ERROR: brew not found. Run install-homebrew.sh first."
    exit 1
fi

# pam_reattach reattaches sudo to the user's GUI session so Touch ID works
# inside terminal multiplexers (tmux/zellij), where it otherwise can't.
if ! brew list pam-reattach &>/dev/null; then
    echo "Installing pam-reattach..."
    brew install pam-reattach
fi
reattach="$(brew --prefix)/lib/pam/pam_reattach.so"

sudo_local="/etc/pam.d/sudo_local"

if [[ -f "$sudo_local" ]] && grep -q "pam_tid.so" "$sudo_local"; then
    echo "✓ Touch ID for sudo already configured ($sudo_local)"
    exit 0
fi

echo "Writing $sudo_local (requires sudo)..."
sudo tee "$sudo_local" >/dev/null <<EOF
# Managed by dotfiles (scripts/setup-touchid-sudo.sh)
auth       optional       $reattach
auth       sufficient     pam_tid.so
EOF

echo "✓ Touch ID for sudo enabled (open a new shell to use it)"
