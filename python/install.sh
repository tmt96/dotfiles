#!/usr/bin/env zsh

dir_name=${0:a:h}
source $dir_name/../function.sh

echo
echo "Install python2 and python3 using pyenv..."
backup_and_link $dir_name/default-packages $(pyenv root)/default-packages

LATEST_VERSION_PY2=$(pyenv install -l | egrep "^[[:space:]]*2.[0-9]+.[0-9]+$" | tail -1)
LATEST_VERSION_PY2=${LATEST_VERSION_PY2// /}
pyenv install $LATEST_VERSION_PY2 -s > dev/null

LATEST_VERSION_PY3=$(pyenv install -l | egrep "^[[:space:]]*3.[0-9]+.[0-9]+$" | tail -1)
LATEST_VERSION_PY3=${LATEST_VERSION_PY3// /}
pyenv install $LATEST_VERSION_PY3 -s > /dev/null

pyenv global $LATEST_VERSION_PY2 $LATEST_VERSION_PY3 > /dev/null 2>&1

if [ ! -d "$(pyenv root)/plugins/pyenv-default-packages" ]; then
    git clone https://github.com/jawshooah/pyenv-default-packages.git $(pyenv root)/plugins/pyenv-default-packages > /dev/null
fi
if [ ! -d "$(pyenv root)/plugins/pyenv-update" ]; then
    git clone https://github.com/pyenv/pyenv-update.git $(pyenv root)/plugins/pyenv-update > /dev/null
fi

echo "Finished installing python!"

echo "Installing poetry - modern project manager for Python"
curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python > /dev/null 2>&1
echo "Finished installing poetry"
echo