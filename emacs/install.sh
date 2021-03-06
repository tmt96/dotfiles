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
    git --git-dir=${HOME}/spacemacs checkout develop
    git --git-dir=${HOME}/spacemacs pull --abort
fi

echo "Symlinking spacemacs config..."
backup_and_link $dir_name/.spacemacs ${HOME}/.spacemacs

if [ ! -d ${HOME}/doom-emacs ]; then
    echo "You don't have an spacemacs config. Cloning spacemacs..."
    git clone https://github.com/hlissner/doom-emacs ${HOME}/doom-emacs
else
    git --git-dir=${HOME}/doom-emacs pull --abort
fi

echo "Symlinking Doom emacs config..."
backup_and_link $dir_name/.doom.d ${HOME}/.doom.d
${HOME}/doom-emacs/bin/doom install -y

echo "Installing chemacs & configuring profiles"
wget -O ~/.emacs https://raw.githubusercontent.com/plexus/chemacs/master/.emacs
backup_and_link $dir_name/.emasc-profiles.el

# TODO: Configure emacs daemon & client
echo "Configure emacs daemon..."
ln -sfn $dir_name/emacs.daemon.plist ${HOME}/Library/LaunchAgents/org.gnu.emacs.daemon.plist
launchctl load ${HOME}/Library/LaunchAgents/org.gnu.emacs.daemon.plist

echo "Done configuring emacs!!"
echo