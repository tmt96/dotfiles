#!/usr/bin/env bash

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
curl -L https://iterm2.com/shell_integration/zsh \
-o ~/.iterm2_shell_integration.zsh
dir_name=`dirname "${BASH_SOURCE[0]}"`
dir_name=`( cd "$dir_name" && pwd )`

# commonrc
test -f ~/.zshenv || touch ~/.zshenv
if ! grep commonrc ~/.zshenv > /dev/null 2>&1; then
cat <<-EOF >> ~/.zshenv
source $dir_name/../.commonrc
EOF
fi

# z-files
for file in "$dir_name"/z*; do
filename="$(basename $file)"
test -f ~/."$filename" || touch ~/."$filename"
if ! grep "$file" ~/."$filename" > /dev/null 2>&1; then
cat <<-EOF >> ~/."$filename"
source $file
EOF
fi
done

# iTerm
test -f ~/.zshrc || touch ~/.zshrc
if ! grep iterm2_shell_integration ~/.zshrc > /dev/null 2>&1; then
cat <<-EOF >> ~/.zshrc
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
EOF
fi
