#!/usr/bin/env bash

echo "Welcome to tmt's dotfiles."
echo "The process requires your root account password to proceed."
sudo -v

. ./brew/install.sh
. ./zsh/install.sh
. ./bash/install.sh
. ./emacs/install.sh

# Ruby
rbenv init
LATEST_VERSION=$(rbenv install -l | grep -v - | tail -1)
rbenv version | read CUR_VER _
if [ "$LATEST_VERSION" == "$CUR_VER" ]; then
    rbenv install $LATEST_VERSION -N
    rbenv global $LATEST_VERSION
fi;
gem install rubocop solargraph

# Rust
curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env
rustup default stable
rustup update stable
rustup component add rls rust-analysis rust-src clippy


echo "Switching you over to zsh"
if ! grep -q "$(which zsh)" /etc/shells; then
    sudo sh -c "echo $(which zsh) >> /etc/shells"
fi
chsh -s $(which zsh)

echo "Remember to logout to change login shell"