# Custom PATH additions (mise handles language toolchains)

# Local bin folders (user scripts)
export PATH="${HOME}/.bin:$PATH"

# Cargo bin for tools installed via `cargo install` (outside mise)
export PATH="$HOME/.cargo/bin:$PATH"

# Note: Homebrew is configured in .zprofile via `brew shellenv`
# Note: mise handles nodejs, python, ruby, go, pnpm, yarn, poetry, etc.
