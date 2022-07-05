# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
export ZSH="/Users/cedric/.oh-my-zsh"

alias ls="ls -g"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bullet-train"

BULLETTRAIN_PROMPT_ORDER=(
  status
  custom
  context
  dir
  aws
  git
  cmd_exec_time
)

BULLETTRAIN_KCTX_KCONFIG="$HOME/.kube/config"
BULLETTRAIN_STATUS_EXIT_SHOW=true
BULLETTRAIN_RUBY_FG=black
BULLETTRAIN_DIR_FG=black
BULLETTRAIN_GIT_FG=white
BULLETTRAIN_GIT_BG=black
BULLETTRAIN_DIR_EXTENDED=2
BULLETTRAIN_KCTX_FG=black

plugins=(
  add-python-bin-to-path
  add-user-bin-to-path
  brew
  colored-man-pages
  command-not-found
  common-aliases
  docker
  docker-compose
  dotenv
  flutter
  git
  git-extras
  gnu-utils
  gradle
  history-substring-search
  krew
  last-working-dir
  nmap
  npm
  pip
  pj
  poetry
  rsync
  sudo
  yarn
  zsh-lerna
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='code'
fi

export ARCHFLAGS="-arch arm64"

alias zshconfig="code ~/.zshrc"
alias omz="code ~/.oh-my-zsh"

# alias ibrew='arch -x86_64 /usr/local/bin/brew'
# alias iasdf='arch -x86_64 /opt/homebrew/bin/asdf'

# source $HOME/.asdf/asdf.sh
# source $HOME/.asdf/completions/asdf.bash

# export KUBECONFIG=~/.kube/config:~/.kube/spantreekube
export KUBECONFIG=~/.kube/config

# source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
# source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.asdf/shims:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/cedric/.sdkman"
[[ -s "/Users/cedric/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/cedric/.sdkman/bin/sdkman-init.sh"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"
