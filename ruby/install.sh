#!/usr/bin/env zsh

dir_name=${0:a:h}
source $dir_name/../function.sh

echo
echo "Install ruby using rbenv..."
backup_and_link $dir_name/default-gems $(rbenv root)/default-gems

LATEST_VERSION=$(rbenv install -l | grep -v - | tail -1)
LATEST_VERSION=${LATEST_VERSION// /}
rbenv install $LATEST_VERSION -s
rbenv global $LATEST_VERSION

echo "Finished installing ruby!"
echo