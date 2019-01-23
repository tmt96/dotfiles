#!/usr/bin/env bash

dir_name=${0:a:h}
source $dir_name/../function.sh

echo
echo "Configuring VSCode..."
echo "Installing your extensions"
for line in $(cat "./vscode/extensions"); do
    code --install-extension --force $line
done

echo "Configure settings & keybindings"
dest_dir=${HOME}/Library/Application\ Support/Code/User
for file in $dir_name/*.json; do
    filename=$(basename $file)
    echo "Configuring $filename"
    backup_and_link $dir_name/$filename $dest_dir/$filename
done

echo "Done configuring VSCode!!"
echo
