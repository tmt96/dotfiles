#!/usr/bin/env zsh

echo
echo "Syncing your zsh prezto config..."

dir_name=${0:a:h}

if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
    echo "You don't have prezto cloned. Cloning prezto..."
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

echo "Configuring .zshenv"
# commonrc
test -f ~/.zshenv || touch ~/.zshenv
if ! grep commonrc ~/.zshenv > /dev/null 2>&1; then
    echo "source $dir_name/../.commonrc" >> ~/.zshenv
fi

# z-files
for file in $dir_name/z*; do
    filename="$(basename $file)"
    echo "Configuring .$filename"
    test -f ~/."$filename" || touch ~/."$filename"
    if ! grep "$file" ~/."$filename" > /dev/null 2>&1; then
        echo "source $file" >>  ~/."$filename"
    fi
done

echo "Adding iTerm integration..."
curl -L https://iterm2.com/shell_integration/zsh \
-o ~/.iterm2_shell_integration.zsh
test -f ~/.zshrc || touch ~/.zshrc
if ! grep iterm2_shell_integration ~/.zshrc > /dev/null 2>&1; then
    echo "test -e \"${HOME}/.iterm2_shell_integration.zsh\" && source \"${HOME}/.iterm2_shell_integration.zsh\"" ~/.zshrc
fi

echo "Done configuring zsh!!"
echo