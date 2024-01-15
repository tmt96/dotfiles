#!/usr/bin/env zsh

dir_name=${0:a:h}
source $dir_name/../function.sh

echo
echo "Configuring emacs..."
backup ${HOME}/.emacs
backup ${HOME}/.emacs.d

if [ ! -d ${HOME}/spacemacs ]; then
    echo "You don't have an spacemacs config. Cloning spacemacs..."
    git clone --branch develop https://github.com/syl20bnr/spacemacs ${HOME}/spacemacs
else
    git --git-dir=${HOME}/spacemacs/.git checkout develop
    git --git-dir=${HOME}/spacemacs/.git pull
fi

echo "Symlinking spacemacs config..."
backup_and_link $dir_name/.spacemacs ${HOME}/.spacemacs

if [ ! -d ${HOME}/doomemacs ]; then
    echo "You don't have an Doom Emacs config. Cloning Doom Emacs..."
    git clone https://github.com/doomemacs/doomemacs ${HOME}/doomemacs
else
    yes | ${HOME}/doom-emacs/bin/doom upgrade
fi

echo "Symlinking Doom emacs config..."
backup_and_link $dir_name/.doom.d ${HOME}/.doom.d
yes | ${HOME}/doomemacs/bin/doom install

echo "Installing chemacs & configuring profiles"
git clone https://github.com/plexus/chemacs2.git ~/.emacs.d
backup_and_link $dir_name/.emacs-profiles.el $HOME/.emacs-profiles.el

# TODO: Configure emacs daemon & client
echo "Configure emacs daemon..."
ln -sfn $dir_name/emacs.daemon.plist ${HOME}/Library/LaunchAgents/gnu.emacs.daemon.plist
launchctl load ${HOME}/Library/LaunchAgents/gnu.emacs.daemon.plist

echo "Done configuring emacs!!"
echo