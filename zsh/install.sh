#!/usr/bin/env zsh

echo
echo "Syncing your zsh prezto config..."

dir_name=${0:a:h}
source $dir_name/../function.sh

if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
    echo "You don't have prezto cloned. Cloning prezto..."
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto" > /dev/null
else
    zprezto-update > /dev/null
fi

echo "Configuring .zshenv"
# commonrc
test -f ${HOME}/.zshenv || touch ${HOME}/.zshenv
if ! grep commonrc ${HOME}/.zshenv > /dev/null 2>&1; then
    echo "source $dir_name/../.commonrc" >> ${HOME}/.zshenv
fi

# z-files
for file in $dir_name/z*; do
    filename="$(basename $file)"
    echo "Configuring .$filename"
    test -f ${HOME}/."$filename" || touch ${HOME}/."$filename"
    if ! grep "$file" ${HOME}/."$filename" > /dev/null 2>&1; then
        echo "source $file" >>  ${HOME}/."$filename"
    fi
done

echo "Configuring p10k theme"
backup_and_link $dir_name/.p10k.zsh ${HOME}/.p10k.zsh

echo "Adding iTerm integration..."
curl -LsSf https://iterm2.com/shell_integration/zsh \
-o ${HOME}/.iterm2_shell_integration.zsh > /dev/null

echo "Configure thefuck for zsh"
test -f ${HOME}/.fuck.zsh || touch ${HOME}/.fuck.zsh
SHELL=zsh thefuck --alias >> ${HOME}/.fuck.zsh

echo "Configure zoxide for zsh"
echo "Configure thefuck for zsh"
test -f ${HOME}/.zoxide.zsh || touch ${HOME}/.zoxide.zsh
zoxide init zsh >> ${HOME}/.zoxide.zsh

echo "Done configuring zsh!!"
echo