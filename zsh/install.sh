#!/usr/bin/env bash

echo
echo "Syncing your zsh prezto config..."

dir_name=`dirname "${BASH_SOURCE[0]}"`
dir_name=`( cd "$dir_name" && pwd )`

if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
    echo "You don't have prezto cloned. Cloning prezto..."
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

echo "Configuring .zshenv"
# commonrc
test -f ~/.zshenv || touch ~/.zshenv
if ! grep commonrc ~/.zshenv > /dev/null 2>&1; then
cat <<-EOF >> ~/.zshenv
source $dir_name/../.commonrc
EOF
fi

# z-files
for file in "$dir_name/z*"; do
    filename="$(basename $file)"
    echo "Configuring .${filename}"
    test -f ~/."$filename" || touch ~/."$filename"
    if ! grep "$file" ~/."$filename" > /dev/null 2>&1; then
    cat <<-EOF >> ~/."$filename"
source $file
EOF
    fi
done

echo "Adding iTerm integration..."
curl -L https://iterm2.com/shell_integration/zsh \
-o ~/.iterm2_shell_integration.zsh
test -f ~/.zshrc || touch ~/.zshrc
if ! grep iterm2_shell_integration ~/.zshrc > /dev/null 2>&1; then
cat <<-EOF >> ~/.zshrc
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
EOF
fi

echo "Done configuring zsh!!"
echo