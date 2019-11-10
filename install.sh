#!/usr/bin/env zsh

echo "Welcome to tmt's dotfiles."
echo "The process requires your root account password to proceed."
sudo -v

root_dir=${0:a:h}
source $root_dir/brew/install.sh
source $root_dir/bash/install.sh
source $root_dir/zsh/install.sh
source $root_dir/vscode/install.sh
source $root_dir/emacs/install.sh
source $root_dir/iterm2/install.sh
source $root_dir/ruby/install.sh
source $root_dir/python/install.sh
source $root_dir/node/install.sh
source $root_dir/rust/install.sh

echo "Switching you over to zsh"
zsh_path=/usr/local/bin/zsh
if ! grep -q $zsh_path /etc/shells; then
    sudo sh -c "echo $zsh_path >> /etc/shells"
fi
sudo dscl . -change /Users/$USER UserShell $SHELL $zsh_path > /dev/null 2>&1

echo "Remember to logout to change login shell"