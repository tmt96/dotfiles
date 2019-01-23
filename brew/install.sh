#!/usr/bin/env zsh

dir_name=${0:a:h}
source $dir_name/../function.sh

echo
echo "Syncing apps through Homebrew..."
if ! [ -x "$(command -v brew)" ]; then
    echo "You don't have Homebrew installed. Installing homebrew..."
    xcode-select install
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi;

echo "Installing your apps using Brewfile..."
sudo chown -R $(whoami) /usr/local/lib /usr/local/sbin
brew update
brew bundle --file=$dir_name/Brewfile

echo "Linking your shell config files..."
backup_and_link $dir_name/Brewfile ${HOME}/Brewfile

echo "Done installing apps from Homebrew!!"
echo