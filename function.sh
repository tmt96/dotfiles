#!/usr/bin/env zsh

function backup {
    if [ -f $1 ]; then
        yes | cp -LR $1 $1.backup
        yes | rm $1
    fi
}

function backup_and_link {
    backup $2
    ln -sfn $1 $2
}