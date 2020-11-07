#!/usr/bin/env bash

echo "Configuring bash..."
dir_name=`dirname "${BASH_SOURCE[0]}"`
dir_name=`( cd "$dir_name" > /dev/null 2>&1 && pwd )`

echo "Configuring .bash_profile..."
# commonrc
test -f ${HOME}/.bash_profile || touch ${HOME}/.bash_profile
if ! grep commonrc ${HOME}/.bash_profile > /dev/null 2>&1; then
    echo "source $dir_name/../.commonrc" >> ${HOME}/.bash_profile
fi

for file in $dir_name/b*; do
    filename="$(basename $file)"
    echo "Configuring .$filename"
    test -f ${HOME}/."$filename" || touch ${HOME}/."$filename"
    if ! grep "$file" ${HOME}/."$filename" > /dev/null 2>&1; then
        echo "source $file" >>  ${HOME}/."$filename"
    fi
done


echo "Adding iTerm integration..."
curl -LsSf https://iterm2.com/shell_integration/bash \
-o ${HOME}/.iterm2_shell_integration.bash
if ! grep iterm2_shell_integration ${HOME}/.bash_profile > /dev/null 2>&1; then
    echo "test -e \"${HOME}/.iterm2_shell_integration.bash\" && source \"${HOME}/.iterm2_shell_integration.bash\"" ${HOME}/.bash_profile
fi

source ${HOME}/.bash_profile
echo "Done configuring bash!!"
echo
