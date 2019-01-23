#!/usr/bin/env zsh

dir_name=${0:a:h}
source $dir_name/../function.sh

echo
echo "Configuring emacs..."
backup ${HOME}/.emacs
if [ ! -f ${HOME}/.spacemacs ]; then
    echo "You don't have an spacemacs config. Cloning spacemacs..."
    backup ${HOME}/.emacs.d
    git clone https://github.com/syl20bnr/spacemacs ${HOME}/.emacs.d
fi

echo "Symlinking spacemacs config..."
backup_and_link $dir_name/.spacemacs ${HOME}/.spacemacs

# TODO: Configure emacs daemon & client
echo "Configure emacs daemon..."
ln -sfn $dir_name/emacs.daemon.plist ${HOME}/Library/LaunchAgents/org.gnu.emacs.daemon.plist
launchctl load ${HOME}/Library/LaunchAgents/org.gnu.emacs.daemon.plist

echo "Done configuring emacs!!"
echo