#!/usr/bin/env zsh

echo
echo "Configuring emacs..."
if [ ! -d ${HOME}/.emacs.d ]; then
    echo "You don't have an emacs config. Cloning spacemacs..."
    git clone https://github.com/syl20bnr/spacemacs ${HOME}/.emacs.d
fi

echo "Symlinking spacemacs config..."
dir_name=${0:a:h}
ln -sfn $dir_name/.spacemacs ${HOME}/.spacemacs

# TODO: Configure emacs daemon & client
echo "Configure emacs daemon"
ln -sfn $dir_name/emacs.daemon.plist ${HOME}/Library/LaunchAgents/org.gnu.emacs.daemon.plist
launchctl load ${HOME}/Library/LaunchAgents/org.gnu.emacs.daemon.plist

echo "Done configuring emacs!!"
echo