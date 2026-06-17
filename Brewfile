cask_args appdir: "/Applications"

###############################################################################
# Profiles
#
# Choose what gets installed with HOMEBREW_PROFILE (default: personal).
# The HOMEBREW_ prefix is required: `brew bundle` scrubs all other env vars.
#   HOMEBREW_PROFILE=personal   everything (default)
#   HOMEBREW_PROFILE=work       dev + comms + cloud GUI apps; no media/creative
#   HOMEBREW_PROFILE=server     CLI tools only; no GUI casks
#
# Force any group on/off regardless of profile (1/0):
#   HOMEBREW_INCLUDE_GUI=0   HOMEBREW_INCLUDE_DEV=1   HOMEBREW_INCLUDE_AI=0
#   HOMEBREW_INCLUDE_COMMS=1 HOMEBREW_INCLUDE_CLOUD=0 HOMEBREW_INCLUDE_MEDIA=1
#   HOMEBREW_INCLUDE_CREATIVE=1
#
# CLI formulae are always installed; only cask groups are gated.
###############################################################################
profile = ENV.fetch("HOMEBREW_PROFILE", "personal").downcase

def want?(group, default)
  v = ENV["HOMEBREW_INCLUDE_#{group}"]
  return %w[1 true yes on].include?(v.downcase) unless v.nil?
  default
end

gui      = want?("GUI",      profile != "server")
dev      = want?("DEV",      gui)
ai       = want?("AI",       gui)
comms    = want?("COMMS",    gui)
cloud    = want?("CLOUD",    gui)
media    = want?("MEDIA",    gui && profile == "personal")
creative = want?("CREATIVE", gui && profile == "personal")

###############################################################################
# Taps
###############################################################################
# tap "ringohub/redis-cli"        # Removed: broken/outdated
# tap "heroku/brew"               # Removed: heroku now in homebrew/core
# tap "ankitpokhrel/jira-cli"     # Removed: no longer used
# tap "cirruslabs/cli"            # Removed: no longer used (tart)
# tap "tclass/cloud_sql_proxy"    # Removed: using cloud-sql-proxy v2 gcloud component
tap "ddev/ddev"
tap "runpod/runpodctl"
tap "withgraphite/tap"

###############################################################################
# Core CLI Tools
###############################################################################
brew "git"
brew "git-lfs"
brew "git-filter-repo"
brew "gh"
brew "withgraphite/tap/graphite"
brew "nano"
brew "vim"
brew "tmux"
brew "screen"
brew "zsh"
brew "zsh-completions"
brew "mas"

###############################################################################
# Search & File Tools
###############################################################################
brew "ack"
brew "ripgrep"
brew "jq"
brew "tree"
brew "fdupes"
brew "jdupes"
brew "p7zip"
brew "pbzip2"
brew "unzip"
brew "zip"

###############################################################################
# Network Tools
###############################################################################
brew "curl"
brew "wget"
brew "httpie"
brew "aria2"
brew "socat"
brew "stunnel"
brew "tor"
brew "wireguard-tools"
brew "iperf3"
brew "tcpdump"

###############################################################################
# Development Tools
###############################################################################
brew "autoconf"
brew "cloc"
brew "diffstat"
brew "diffutils"
brew "coreutils"
brew "findutils"
brew "gnu-getopt"
brew "gpatch"
brew "less"
brew "lsof"
brew "make"
brew "watch"
brew "watchexec"
brew "pv"
brew "expect"
brew "ssh-copy-id"
brew "sshpass"

###############################################################################
# Media & Graphics
###############################################################################
brew "ffmpeg"
brew "imagemagick"
brew "graphicsmagick"
brew "exiftool"
brew "sox"
brew "yt-dlp"

###############################################################################
# Database Tools
###############################################################################
brew "postgresql@17"
# brew "aoki/redis-cli/redis-cli"  # Removed: broken tap, use `redis` package if needed
brew "cypher-shell"
brew "kcat"

###############################################################################
# Cloud & Infrastructure
###############################################################################
brew "awscli"                         # Keep for initial bootstrap before mise
brew "doppler"
# brew "teleport"             # Removed: no longer used
# brew "velero"              # Removed: no longer used (also pinned in mise)
brew "supabase"
brew "runpod/runpodctl/runpodctl"
# cloud-sql-proxy: via gcloud component, not brew
#   gcloud components install cloud-sql-proxy
brew "vercel-cli"

###############################################################################
# Kubernetes (tools not in mise)
###############################################################################
brew "helm-docs"
# brew "ksync"                # Removed: disabled in homebrew (2025-08-03)
brew "ctlptl"

###############################################################################
# Container Tools
###############################################################################
brew "ddev/ddev/ddev"
# brew "cirruslabs/cli/tart"           # Removed: no longer used

###############################################################################
# Security & Misc
###############################################################################
brew "gnupg"
brew "bfg"
brew "diceware"
# brew "magic-wormhole"      # Removed: no longer used
brew "semgrep"
brew "testdisk"

###############################################################################
# Language-specific (not in mise)
###############################################################################
brew "cocoapods"
brew "pipenv"
brew "antlr"

###############################################################################
# Other CLI Tools
###############################################################################
brew "asciinema"
brew "htop"
brew "tlrc"                          # provides 'tldr' (replaces disabled tldr formula)
# brew "jira-cli"                      # Removed: no longer used
brew "heroku"
brew "slackdump"
brew "llm"
brew "mosquitto"
brew "caddy"
brew "alembic"
brew "gdal"
brew "graphviz"
brew "pandoc-crossref"

###############################################################################
# Casks - Essentials                                          [gui]
###############################################################################
if gui
  cask "1password"
  cask "1password-cli"
  cask "google-chrome"
  cask "firefox"
  cask "brave-browser"
  cask "iterm2"
  cask "warp"
  cask "raycast"
  cask "rectangle"
  cask "bartender"
  cask "istat-menus"
  cask "cleanshot"
end

###############################################################################
# Casks - Development                                         [dev]
###############################################################################
if dev
  cask "visual-studio-code"
  cask "cursor"
  cask "docker-desktop"
  cask "intellij-idea"
  cask "goland"
  cask "pycharm"
  cask "datagrip"
  cask "dash"
  cask "postman"
  cask "postman-cli"
  cask "insomnia"
  cask "bruno"
  cask "charles"
  cask "ngrok"
  cask "sourcetree"
  cask "lens"
end

###############################################################################
# Casks - AI & Productivity                                   [ai]
###############################################################################
if ai
  cask "claude"
  cask "chatgpt"
  cask "boltai"
  cask "obsidian"
  cask "notion"
  cask "grammarly-desktop"
  cask "superhuman"
  cask "clickup"
  cask "miro"
end

###############################################################################
# Casks - Communication                                       [comms]
###############################################################################
if comms
  cask "slack"
  cask "discord"
  cask "zoom"
  cask "microsoft-teams"
  cask "whatsapp"
  # cask "skype"                # Removed: Microsoft retired Skype (2025)
end

###############################################################################
# Casks - Cloud & VPN                                         [cloud]
###############################################################################
if cloud
  cask "google-drive"
  cask "gcloud-cli"  # Keep in brew (mise version needs sudo)
  cask "expressvpn"
  cask "viscosity"
  cask "pritunl"
end

###############################################################################
# Casks - Media                                               [media]
###############################################################################
if media
  cask "vlc"
  cask "iina"
  cask "spotify"
  cask "plex"
  cask "plex-media-server"
  cask "obs"
  cask "handbrake-app"
  cask "losslesscut"
  cask "audacity"
  cask "descript"
end

###############################################################################
# Casks - Creative                                            [creative]
###############################################################################
if creative
  cask "adobe-creative-cloud"
  cask "figma"
  cask "sketch"
  cask "blender"
  cask "ableton-live-suite"
  cask "splice"
  cask "native-access"
  cask "waves-central"
  cask "insta360-studio"
  cask "lrtimelapse"
end

###############################################################################
# Casks - Utilities                                           [gui]
###############################################################################
if gui
  cask "betterzip"
  cask "rar"
  cask "caffeine"
  # cask "cheatsheet"           # Removed: disabled in homebrew (2025-11-09)
  cask "keyboard-cleaner"
  cask "smcfancontrol"
  cask "android-file-transfer"
  cask "transmit"
  cask "secure-pipes"
  cask "vnc-viewer"
end

###############################################################################
# Casks - Other                                               [gui]
###############################################################################
if gui
  # cask "kindle"               # Removed: cask gone; Kindle is Mac App Store only now
  cask "deckset"
  cask "camunda-modeler"
  cask "keybase"
  cask "tor-browser"
  cask "google-earth-pro"
  # cask "phantomjs"            # Removed: discontinued project, use headless Chrome/Playwright
  cask "multipass"
  cask "mqtt-explorer"
  # cask "nomad-menu"           # Removed: disabled in homebrew (2025-07-10)
  cask "ubiquiti-unifi-controller"
  cask "elgato-control-center"
  cask "elgato-stream-deck"
  cask "setapp"
  cask "microsoft-office"
  cask "xquartz"
  cask "macfuse"
  # cask "mactex"  # Large (~4GB), install manually: brew install --cask mactex
end

###############################################################################
# Fonts                                                       [gui]
###############################################################################
if gui
  cask "font-meslo-for-powerline"
  cask "font-fira-code-nerd-font"
end

###############################################################################
# NOTE: These tools are managed by mise, NOT brew:
# - Languages: node, python, ruby, go, rust, java, deno, bun
# - Package managers: pnpm, yarn, poetry, uv
# - K8s: kubectl, helm, k9s, kops, kubie, kustomize, stern, krew, skaffold
# - Cloud: awscli, eksctl, gcloud (also in brew for bootstrap)
# - Infra: terraform, terragrunt, sops, nomad, argo, pulumi
# - Build: gradle, maven
# - CLI: just, eza, starship, zellij, kind, tilt, doctl
# - DevOps: ansible (via uv tool install ansible-core)
###############################################################################
