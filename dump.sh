#!/usr/bin/env zsh

echo "We will copy your current config to the dotfiles repository"

echo "Dumping app list to Brewfile"
brew bundle dump -f --describe --file=./brew/Brewfile
