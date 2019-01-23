#!/usr/bin/env zsh

function backup {
    if [ -f $1 ]; then
        mv $1 $1.backup
    fi
}

function backup_and_link {
    backup $2
    ln -sfn $1 $2
}