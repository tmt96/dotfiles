#!/usr/bin/env bash

echo "Configuring bash..."
dir_name=`dirname "${BASH_SOURCE[0]}"`
dir_name=`( cd "$dir_name" && pwd )`

echo "Configuring .bash_profile..."
# commonrc
test -f ~/.bash_profile || touch ~/.bash_profile
if ! grep commonrc ~/.bash_profile > /dev/null 2>&1; then
cat <<-EOF >> ~/.bash_profile
source $dir_name/../.commonrc
EOF
fi

echo "Adding iTerm integration..."
curl -L https://iterm2.com/shell_integration/bash \
-o ~/.iterm2_shell_integration.bash
if ! grep iterm2_shell_integration ~/.bash_profile > /dev/null 2>&1; then
cat <<-EOF >> ~/.bash_profile
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
EOF
fi

source ~/.bash_profile
echo "Done configuring bash!!"
echo