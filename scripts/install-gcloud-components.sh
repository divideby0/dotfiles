#!/usr/bin/env bash
#
# Install gcloud CLI components (not managed by brew/mise)
#

set -e

echo "=== gcloud Components Setup ==="

# Components to install. cloud-sql-proxy is the v2 Cloud SQL Auth Proxy;
# gcloud-crc32c provides fast checksums for gsutil transfers.
COMPONENTS=(
    cloud-sql-proxy
    gcloud-crc32c
)

# Ensure gcloud is available (installed via the gcloud-cli cask)
if ! command -v gcloud &>/dev/null; then
    echo "ERROR: gcloud not found. Install the gcloud-cli cask first (brew bundle)."
    exit 1
fi

# Figure out which requested components are not yet installed
installed=$(gcloud components list --filter="state.name=Installed" \
    --format="value(id)" 2>/dev/null)

missing=()
for c in "${COMPONENTS[@]}"; do
    if ! grep -qx "$c" <<<"$installed"; then
        missing+=("$c")
    fi
done

if [[ ${#missing[@]} -eq 0 ]]; then
    echo "✓ All gcloud components already installed"
    exit 0
fi

echo "Installing components: ${missing[*]}"
gcloud components install --quiet "${missing[@]}"

echo "✓ gcloud components setup complete"
