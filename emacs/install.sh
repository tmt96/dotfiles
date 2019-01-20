#!/usr/bin/env zsh

echo
echo "Configuring emacs..."
if [ ! -d ~/.emacs.d ]; then
    echo "You don't have an emacs config. Cloning spacemacs..."
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

echo "Symlinking spacemacs config..."
dir_name=${0:a:h}
ln -sfn $dir_name/.spacemacs ~/.spacemacs

# TODO: Configure emacs daemon & client

echo "Done configuring emacs!!"
echo