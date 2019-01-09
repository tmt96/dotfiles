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
rbenv install $(rbenv install -l | grep -v - | tail -1)
# Rust
curl https://sh.rustup.rs -sSf | sh

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

echo "Remember to "