#!/usr/bin/env zsh

dir_name=${0:a:h}
source $dir_name/../function.sh

echo
echo "Install ruby using rbenv..."
backup_and_link $dir_name/default-gems $(rbenv root)/default-gems

LATEST_VERSION=$(rbenv install -l | grep "^[[:space:]]*[0-9]\{1,\}.[0-9]\{1,\}.[0-9]\{1,\}$"| tail -1)
LATEST_VERSION=${LATEST_VERSION// /}
rbenv install $LATEST_VERSION -s
rbenv global $LATEST_VERSION

mkdir -p "$(rbenv root)"/plugins
if [ ! -d "$(rbenv root)/plugins/rbenv-which-ext" ]; then
    git clone https://github.com/yyuu/rbenv-which-ext.git "$(rbenv root)/plugins/rbenv-which-ext"
fi
if [ ! -d "$(rbenv root)/plugins/rbenv-update" ]; then
    git clone https://github.com/rkh/rbenv-update.git "$(rbenv root)/plugins/rbenv-update"
fi

echo "Finished installing ruby!"
echo
