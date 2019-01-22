#!/usr/bin/env zsh

echo
echo "Syncing apps through Homebrew..."
if ! [ -x "$(command -v brew)" ]; then
    echo "You don't have Homebrew installed. Installing homebrew..."
    xcode-select install
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi;

echo "Installing your apps using Brewfile..."
dir_name=${0:a:h}
brew update
brew bundle --file=$dir_name/Brewfile

echo "Linking your shell config files..."
ln -sfn $dir_name/Brewfile ~/Brewfile

echo "Done installing apps from Homebrew!!"
echo