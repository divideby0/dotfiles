#!/usr/bin/env bash
#
# OS detection helper functions
# Source this file to use: source "$(dirname "$0")/lib/detect-os.sh"
#

detect_os() {
    case "$(uname -s)" in
        Darwin)
            echo "macos"
            ;;
        Linux)
            if [[ -f /etc/os-release ]]; then
                . /etc/os-release
                case "$ID" in
                    ubuntu|debian|pop)
                        echo "debian"
                        ;;
                    amzn|rhel|centos|fedora)
                        echo "redhat"
                        ;;
                    alpine)
                        echo "alpine"
                        ;;
                    *)
                        # Check for Synology
                        if [[ -f /etc/synoinfo.conf ]]; then
                            echo "synology"
                        else
                            echo "linux"
                        fi
                        ;;
                esac
            elif [[ -f /etc/synoinfo.conf ]]; then
                echo "synology"
            else
                echo "linux"
            fi
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

detect_arch() {
    case "$(uname -m)" in
        x86_64|amd64)
            echo "x86_64"
            ;;
        aarch64|arm64)
            echo "arm64"
            ;;
        armv7l|armhf)
            echo "arm"
            ;;
        *)
            echo "$(uname -m)"
            ;;
    esac
}

is_macos() {
    [[ "$(detect_os)" == "macos" ]]
}

is_linux() {
    [[ "$(uname -s)" == "Linux" ]]
}

is_synology() {
    [[ "$(detect_os)" == "synology" ]]
}

has_command() {
    command -v "$1" &>/dev/null
}

# Package manager helpers
pkg_install() {
    local os=$(detect_os)
    case "$os" in
        macos)
            brew install "$@"
            ;;
        debian)
            sudo apt-get install -y "$@"
            ;;
        redhat)
            sudo yum install -y "$@"
            ;;
        alpine)
            sudo apk add "$@"
            ;;
        synology)
            # Synology uses opkg if available
            if has_command opkg; then
                sudo opkg install "$@"
            else
                echo "Warning: No package manager available on Synology"
                return 1
            fi
            ;;
        *)
            echo "Unknown OS: $os"
            return 1
            ;;
    esac
}
