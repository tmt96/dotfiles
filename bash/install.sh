#!/usr/bin/env bash

echo "Configuring bash..."
dir_name=`dirname "${BASH_SOURCE[0]}"`
dir_name=`( cd "$dir_name" && pwd )`

echo "Configuring .bash_profile..."
# commonrc
test -f ~/.bash_profile || touch ~/.bash_profile
if ! grep commonrc ~/.bash_profile > /dev/null 2>&1; then
    echo "source $dir_name/../.commonrc" >> ~/.bas_profile
fi

echo "Adding iTerm integration..."
curl -L https://iterm2.com/shell_integration/bash \
-o ~/.iterm2_shell_integration.bash
if ! grep iterm2_shell_integration ~/.bash_profile > /dev/null 2>&1; then
    echo "test -e \"${HOME}/.iterm2_shell_integration.bash\" && source \"${HOME}/.iterm2_shell_integration.bash\"" ~/.bash_profile
fi

source ~/.bash_profile
echo "Done configuring bash!!"
echo