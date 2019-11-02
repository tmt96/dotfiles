#!/usr/bin/env zsh

dir_name=${0:a:h}
source $dir_name/../function.sh

echo
echo "Install node using nodenv..."
backup_and_link $dir_name/default-packages $(nodenv root)/default-packages

LATEST_VERSION=$(nodenv install -l | egrep "^[[:space:]]*[0-9]+.[0-9]+.[0-9]+$" | tail -1)
LATEST_VERSION=${LATEST_VERSION// /}
nodenv install $LATEST_VERSION -s > /dev/null 2>&1
nodenv global $LATEST_VERSION > /dev/null 2>&1

echo "Finished installing node!"
echo
