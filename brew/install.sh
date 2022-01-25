#!/usr/bin/env zsh

dir_name=${0:a:h}
source $dir_name/../function.sh

echo
echo "Syncing apps through Homebrew..."
if ! [ -x "$(command -v brew)" ]; then
    echo "You don't have Homebrew installed. Installing homebrew..."
    xcode-select install
    if getopts "l"; then
        git clone https://github.com/Homebrew/brew ${HOME}/homebrew
        eval "$(${HOME}/homebrew/bin/brew shellenv)"
        brew update --force --quiet
        chmod -R go-w "$(brew --prefix)/share/zsh"
        if ! grep brew ${HOME}/.zshenv > /dev/null 2>&1; then
            echo 'eval "$($HOME/bin/brew shellenv)"' >> $HOME/.zshenv
        fi
    else 
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        if ! grep brew ${HOME}/.zshenv > /dev/null 2>&1; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ${HOME}/.zshenv
        fi
fi;

echo "Installing your apps using Brewfile..."
brew update > /dev/null 2>&1
brew bundle --file=$dir_name/Brewfile

echo "Linking your Brewfile..."
backup_and_link $dir_name/Brewfile ${HOME}/Brewfile

echo "Done installing apps from Homebrew!!"
echo
