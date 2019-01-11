#!/usr/bin/env bash

echo "Welcome to tmt's dotfiles. The process requires your root account password to proceed."
sudo -v

if ! [ -x "$(command -v brew)" ]; then
    echo "Installing homebrew..."
    xcode-select install
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi;

echo "Installing your apps..."
brew bundle
# Ruby
rbenv init
LATEST_VERSION=$(rbenv install -l | grep -v - | tail -1)
rbenv version | read CUR_VER _
if [ "$LATEST_VERSION" == "$CUR_VER" ]; then
    rbenv install $LATEST_VERSION -N
    rbenv global $LATEST_VERSION
fi;
# Rust
curl https://sh.rustup.rs -sSf | sh -s -- -y

echo "Linking your shell config files..."
ln -sfn $(pwd)/Brewfile ~/Brewfile

echo "Syncing your application preference..."
# spacemacs
# git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

echo "Switching you over to zsh"
if ! grep -q "$(which zsh)" /etc/shells; then
    sudo sh -c "echo $(which zsh) >> /etc/shells"
fi
chsh -s $(which zsh)

echo "Remember to logout to change login shell"