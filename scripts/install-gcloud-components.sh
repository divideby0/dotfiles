#!/usr/bin/env bash
#
# Install gcloud CLI components (not managed by brew/mise)
#

set -e

echo "=== gcloud Components Setup ==="

# Components to install (brew/mise cannot manage these):
#   alpha / beta          - preview command surfaces
#   gke-gcloud-auth-plugin - kubectl auth for GKE (required since k8s 1.26)
#   cloud-sql-proxy       - v2 Cloud SQL Auth Proxy
#   gcloud-crc32c         - fast checksums for gsutil transfers
#   terraform-tools       - `gcloud beta terraform vet` policy validation
#   log-streaming         - `gcloud alpha logging tail`
COMPONENTS=(
    alpha
    beta
    gke-gcloud-auth-plugin
    cloud-sql-proxy
    gcloud-crc32c
    terraform-tools
    log-streaming
)

# Ensure gcloud is available (installed via the gcloud-cli cask)
if ! command -v gcloud &>/dev/null; then
    echo "ERROR: gcloud not found. Install the gcloud-cli cask first (brew bundle)."
    exit 1
fi

# Figure out which requested components are not yet installed. A component
# only needs installing when its state is "Not Installed"; both "Installed"
# and "Update Available" mean it is already present (updates are handled
# separately via `gcloud components update`).
not_installed=$(gcloud components list --filter="state.name='Not Installed'" \
    --format="value(id)" 2>/dev/null)

missing=()
for c in "${COMPONENTS[@]}"; do
    if grep -qx "$c" <<<"$not_installed"; then
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
