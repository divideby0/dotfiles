# dotfiles

Personal dotfiles for macOS (Apple Silicon).

## Fresh Mac Setup

```bash
# 1. Install Xcode CLI tools (prompted automatically)
xcode-select --install

# 2. Clone this repo
git clone https://github.com/divideby0/dotfiles.git ~/src/divideby0/dotfiles

# 3. Run bootstrap
cd ~/src/divideby0/dotfiles
./bootstrap.sh
```

The bootstrap script will:
1. Install Rosetta (Apple Silicon)
2. Install Homebrew and all packages from Brewfile
3. Install Oh My Zsh
4. Create symlinks for all dotfiles
5. Install mise and all language runtimes
6. Install Python tools via uv (ansible, etc.)

## What's Included

### Package Management

- **Homebrew**: macOS packages and casks (see `Brewfile`)
- **mise**: Language runtimes and dev tools (see `mise/tool-versions`)
- **uv**: Python CLI tools like ansible

### Shell

- **zsh** with Oh My Zsh
- **Starship** prompt with custom powerline theme
- Lazy-loaded completions for fast startup
- Trimmed plugin set for performance

### Development Tools

Languages managed by mise:
- Node.js, Python, Ruby, Go, Rust, Java, Deno, Bun

Kubernetes tools:
- kubectl, helm, k9s, kops, kubie, kind, tilt, skaffold

Infrastructure:
- Terraform, Terragrunt, Pulumi, Ansible

### Editors

- Cursor and VSCode share the same settings
- Claude Code global configuration

## Structure

```
dotfiles/
├── bootstrap.sh              # Fresh Mac setup (run this first)
├── install.sh                # Symlink installer (idempotent)
├── Brewfile                  # Homebrew packages and casks
├── scripts/
│   ├── install-homebrew.sh   # Homebrew + brew bundle
│   ├── install-mise.sh       # mise + tool installations
│   ├── install-oh-my-zsh.sh  # Oh My Zsh
│   └── install-uv-tools.sh   # Python tools (ansible, etc.)
├── shell/
│   ├── zshrc                 # Main shell config
│   ├── zshenv                # Environment variables
│   └── zprofile              # Login shell (Homebrew)
├── git/
│   ├── gitconfig             # Git configuration
│   └── gitignore_global      # Global gitignore
├── editors/
│   └── settings.json         # Shared Cursor/VSCode settings
├── config/
│   └── starship.toml         # Prompt configuration
├── claude/
│   └── CLAUDE.md             # Claude Code global config
├── mise/
│   ├── config.toml           # mise settings
│   └── tool-versions         # Global tool versions
├── oh-my-zsh-custom/
│   └── plugins/
│       └── custom-set-path/  # Custom PATH plugin
└── misc/
    └── screenrc
```

## Post-Install Setup

### Git user info

Create `~/.gitconfig.local`:

```ini
[user]
    name = Your Name
    email = your@email.com
```

### Machine-specific settings

Create `~/.zshrc.local` for local aliases, secrets, or overrides.

## Philosophy

- **mise over brew** for dev tools: Version management per-project
- **Symlinks over copy**: Edit dotfiles, changes apply immediately
- **Secrets in `.local` files**: Never tracked in git
- **Fast startup**: Lazy completions, minimal plugins

## Updating

```bash
cd ~/src/divideby0/dotfiles
git pull
./install.sh          # Re-run symlinks if structure changed
mise install          # Install any new tool versions
brew bundle           # Install any new Homebrew packages
```
