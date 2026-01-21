# dotfiles

Personal dotfiles for macOS (Apple Silicon).

## What's Included

- **Shell**: zsh with Oh My Zsh, optimized for fast startup
- **Prompt**: Starship with custom powerline theme
- **Git**: Sensible defaults, useful aliases, git-lfs support
- **Version Manager**: mise (formerly rtx) for managing language runtimes
- **Completions**: Lazy-loaded for kubectl, helm, docker, pnpm, etc.

## Prerequisites

Install [Homebrew](https://brew.sh) first:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then install required tools:

```bash
brew install starship mise
```

Install Oh My Zsh:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Installation

```bash
git clone git@github.com:divideby0/dotfiles.git ~/src/divideby0/dotfiles
cd ~/src/divideby0/dotfiles
./install.sh
```

The installer:
- Creates symlinks from `~` to this repo
- Backs up existing files to `~/.dotfiles-backup/`
- Is idempotent (safe to run multiple times)

## Post-Install Setup

### Git user info

Create `~/.gitconfig.local`:

```ini
[user]
    name = Your Name
    email = your@email.com
```

### Machine-specific settings

Create `~/.zshrc.local` for local aliases, secrets, or overrides:

```bash
# Example: work-specific settings
export AWS_PROFILE=mycompany
alias deploy='./scripts/deploy.sh'
```

### Install tool versions

```bash
mise install
```

## Structure

```
dotfiles/
├── install.sh                      # Symlink installer
├── shell/
│   ├── zshrc                       # Main shell config
│   ├── zshenv                      # Environment variables
│   └── zprofile                    # Login shell setup (Homebrew)
├── git/
│   ├── gitconfig                   # Git configuration
│   └── gitignore_global            # Global gitignore
├── config/
│   └── starship.toml               # Prompt configuration
├── oh-my-zsh-custom/
│   └── plugins/
│       └── custom-set-path/        # Custom PATH plugin
├── mise/
│   ├── config.toml                 # mise settings
│   └── tool-versions               # Global tool versions
└── misc/
    └── screenrc                    # GNU Screen config
```

## Companion Repos

- **[homebrew-brewfile](https://github.com/divideby0/homebrew-brewfile)**: Brewfile and macOS setup scripts

## Customization

### Adding aliases

Edit `shell/zshrc` or add to `~/.zshrc.local` for machine-specific aliases.

### Changing the prompt

Edit `config/starship.toml`. See [Starship docs](https://starship.rs/config/).

### Adding tool versions

Edit `mise/tool-versions` or use:

```bash
mise use -g nodejs@22
```

## Philosophy

- **Fast startup**: Lazy-load completions, minimal plugins
- **Portable**: No hardcoded paths, secrets in `.local` files
- **Simple**: Symlinks over copy, explicit over magical
