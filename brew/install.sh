#!/usr/bin/env bash

echo
echo "Syncing apps through Homebrew..."
if ! [ -x "$(command -v brew)" ]; then
    echo "You don't have Homebrew installed. Installing homebrew..."
    xcode-select install
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi;

echo "Installing your apps using Brewfile..."
brew bundle --file="$(dirname ${BASH_SOURCE[0]})/Brewfile"

echo "Linking your shell config files..."
dir_name=`dirname "${BASH_SOURCE[0]}"`
dir_name=`( cd "$dir_name" && pwd )`
ln -sfn "$dir_name/Brewfile" ~/Brewfile

echo "Done installing apps from Homebrew!!"
echo