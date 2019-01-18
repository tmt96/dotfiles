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
