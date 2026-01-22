cask_args appdir: "/Applications"

###############################################################################
# Taps
###############################################################################
tap "heroku/brew"
# tap "ringohub/redis-cli"  # Removed: broken/outdated
tap "ankitpokhrel/jira-cli"
tap "cirruslabs/cli"
tap "ddev/ddev"
tap "runpod/runpodctl"
tap "tclass/cloud_sql_proxy"
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
brew "youtube-dl"

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
brew "teleport"
brew "velero"
brew "supabase"
brew "runpod/runpodctl/runpodctl"
brew "tclass/cloud_sql_proxy/cloud_sql_proxy"
brew "vercel-cli"

###############################################################################
# Kubernetes (tools not in mise)
###############################################################################
brew "helm-docs"
brew "ksync"
brew "ctlptl"

###############################################################################
# Container Tools
###############################################################################
brew "ddev/ddev/ddev"
brew "cirruslabs/cli/tart"

###############################################################################
# Security & Misc
###############################################################################
brew "gnupg"
brew "bfg"
brew "diceware"
brew "magic-wormhole"
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
brew "tldr"
brew "ankitpokhrel/jira-cli/jira-cli"
brew "heroku/brew/heroku"
brew "slackdump"
brew "llm"
brew "mosquitto"
brew "caddy"
brew "alembic"
brew "gdal"
brew "graphviz"
brew "pandoc-crossref"

###############################################################################
# Casks - Essentials
###############################################################################
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

###############################################################################
# Casks - Development
###############################################################################
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

###############################################################################
# Casks - AI & Productivity
###############################################################################
cask "claude"
cask "chatgpt"
cask "boltai"
cask "obsidian"
cask "notion"
cask "grammarly-desktop"
cask "superhuman"
cask "clickup"
cask "miro"

###############################################################################
# Casks - Communication
###############################################################################
cask "slack"
cask "discord"
cask "zoom"
cask "microsoft-teams"
cask "whatsapp"
cask "skype"

###############################################################################
# Casks - Cloud & VPN
###############################################################################
cask "google-drive"
cask "gcloud-cli"
cask "expressvpn"
cask "viscosity"
cask "pritunl"

###############################################################################
# Casks - Media
###############################################################################
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

###############################################################################
# Casks - Creative
###############################################################################
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

###############################################################################
# Casks - Utilities
###############################################################################
cask "betterzip"
cask "rar"
cask "caffeine"
cask "cheatsheet"
cask "keyboard-cleaner"
cask "smcfancontrol"
cask "android-file-transfer"
cask "transmit"
cask "secure-pipes"
cask "vnc-viewer"

###############################################################################
# Casks - Other
###############################################################################
cask "kindle"
cask "deckset"
cask "camunda-modeler"
cask "keybase"
cask "tor-browser"
cask "google-earth-pro"
cask "phantomjs"
cask "multipass"
cask "mqtt-explorer"
cask "nomad-menu"
cask "ubiquiti-unifi-controller"
cask "elgato-control-center"
cask "elgato-stream-deck"
cask "setapp"
cask "microsoft-office"
cask "xquartz"
cask "macfuse"
# cask "mactex"  # Large (~4GB), install manually: brew install --cask mactex

###############################################################################
# Fonts
###############################################################################
cask "font-meslo-for-powerline"
cask "font-fira-code-nerd-font"

###############################################################################
# NOTE: These tools are managed by mise, NOT brew:
# - Languages: node, python, ruby, go, rust, java, deno, bun
# - Package managers: pnpm, yarn, poetry, uv
# - K8s: kubectl, helm, k9s, kops, kubie, kustomize, stern, krew, velero, skaffold
# - Cloud: awscli, eksctl, gcloud (also in brew for bootstrap)
# - Infra: terraform, terragrunt, sops, nomad, argo, pulumi
# - Build: gradle, maven
# - CLI: just, eza, starship, zellij, kind, tilt, doctl
# - DevOps: ansible (via uv tool install ansible-core)
###############################################################################
