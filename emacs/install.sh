
echo
echo "Configuring emacs..."
if [ ! -d ~/.emacs.d ]; then
    echo "You don't have an emacs config. Cloning spacemacs..."
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

echo "Symlinking spacemacs config..."
dir_name=`dirname "${BASH_SOURCE[0]}"`
dir_name=`( cd "$dir_name" && pwd )`
ln -sfn "$dir_name/.spacemacs" ~/.spacemacs

# TODO: Configure emacs daemon & client

echo "Done configuring emacs!!"
echo