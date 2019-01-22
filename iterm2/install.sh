#!/usr/bin/env zsh

echo
echo "Syncing your iTerm2 config..."
dir_name=${0:a:h}
# # Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${dir_name}/iterm2/profile"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
echo "Done configuring iTerm2!"
echo