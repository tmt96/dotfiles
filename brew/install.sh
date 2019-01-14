#!/usr/bin/env bash

if ! [ -x "$(command -v brew)" ]; then
    echo "Installing homebrew..."
    xcode-select install
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi;

echo "Installing your apps..."
brew bundle

echo "Linking your shell config files..."
ln -sfn $(pwd)/Brewfile ~/Brewfile

