#!/bin/bash
#
# install without user input

DOTFILES_ROOT="`pwd`"
source "${DOTFILES_ROOT}/script/shared/common.sh"
source "${DOTFILES_ROOT}/script/shared/uninstall.sh"

set -e

install_dotfiles() {
  info 'installing dotfiles'
  for source in `find $DOTFILES_ROOT -maxdepth 2 -name \*.symlink`
  do
    dest="$HOME/.`basename \"${source%.*}\"`"

    link_file $source $dest
  done
}

echo ''
delete_all
install_dotfiles
echo ''
echo '  Installed!'