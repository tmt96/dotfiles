#!/usr/bin/env bash

echo "Configuring bash..."
dir_name=`dirname "${BASH_SOURCE[0]}"`
dir_name=`( cd "$dir_name" && pwd )`

echo "Configuring .bash_profile..."
# commonrc
test -f ${HOME}/.bash_profile || touch ${HOME}/.bash_profile
if ! grep commonrc ${HOME}/.bash_profile > /dev/null 2>&1; then
    echo "source $dir_name/../.commonrc" >> ${HOME}/.bas_profile
fi

echo "Adding iTerm integration..."
curl -L https://iterm2.com/shell_integration/bash \
-o ${HOME}/.iterm2_shell_integration.bash
if ! grep iterm2_shell_integration ${HOME}/.bash_profile > /dev/null 2>&1; then
    echo "test -e \"${HOME}/.iterm2_shell_integration.bash\" && source \"${HOME}/.iterm2_shell_integration.bash\"" ${HOME}/.bash_profile
fi

source ${HOME}/.bash_profile
echo "Done configuring bash!!"
echo