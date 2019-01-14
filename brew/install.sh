#!/usr/bin/env bash

if ! [ -x "$(command -v brew)" ]; then
    echo "Installing homebrew..."
    xcode-select install
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi;

echo "Installing your apps..."
echo "$(dirname ${BASH_SOURCE[0]})/Brewfile"
brew bundle --file="$(dirname ${BASH_SOURCE[0]})/Brewfile"

echo "Linking your shell config files..."
ln -sfn "$(dirname ${BASH_SOURCE[0]})/Brewfile" ~/Brewfile
