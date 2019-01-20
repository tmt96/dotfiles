#!/usr/bin/env zsh

echo "Welcome to tmt's dotfiles."
echo "The process requires your root account password to proceed."
sudo -v

source ./brew/install.sh
source ./bash/install.sh
source ./zsh/install.sh
source ./emacs/install.sh

# Ruby
rbenv init
LATEST_VERSION=$(rbenv install -l | grep -v - | tail -1)
rbenv version | read CUR_VER _
if [ "$LATEST_VERSION" = "$CUR_VER" ]; then
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
zsh_path=/usr/local/bin/zsh
if ! grep -q $zsh_path /etc/shells; then
    sudo sh -c "echo $zsh_path >> /etc/shells"
fi
sudo dscl . -change /Users/$USER UserShell $SHELL $zsh_path > /dev/null 2>&1

echo "Remember to logout to change login shell"