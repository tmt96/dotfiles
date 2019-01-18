echo "CONFIURING EMACS..."
if [ ! -d ~/.emacs.d ]; then
    echo "You don't have an emacs config. Cloning spacemacs..."
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

echo "Symlinking spacemacs config..."
ln -sfn "$(dirname ${BASH_SOURCE[0]})/.spacemacs" ~/.spacemacs

# TODO: Configure emacs daemon & client

echo "DONE CONFIGURING EMACS!!"