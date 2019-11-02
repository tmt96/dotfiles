#!/usr/bin/env zsh

dir_name=${0:a:h}
source $dir_name/../function.sh

echo
echo "Install ruby using rbenv..."
backup_and_link $dir_name/default-gems $(rbenv root)/default-gems

LATEST_VERSION=$(rbenv install -l | egrep "^[[:space:]]*[0-9]+.[0-9]+.[0-9]+$"| tail -1)
LATEST_VERSION=${LATEST_VERSION// /}
rbenv install $LATEST_VERSION -s > /dev/null 2>&1
rbenv global $LATEST_VERSION > /dev/null 2>&1

mkdir -p "$(rbenv root)"/plugins
if [ ! -d "$(rbenv root)/plugins/rbenv-which-ext" ]; then
    git clone https://github.com/yyuu/rbenv-which-ext.git "$(rbenv root)/plugins/rbenv-which-ext" > /dev/null 2>&1
fi
if [ ! -d "$(rbenv root)/plugins/rbenv-update" ]; then
    git clone https://github.com/rkh/rbenv-update.git "$(rbenv root)/plugins/rbenv-update" > /dev/null 2>&1
fi
if [ ! -d "$(rbenv root)/plugins/rbenv-gem-migrate" ]; then
    git clone https://github.com/nabeo/rbenv-gem-migrate.git "$(rbenv root)/plugins/rbenv-gem-migrate" > /dev/null 2>&1
fi

echo "Finished installing ruby!"
echo
