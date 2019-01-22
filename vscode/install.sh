#!/usr/bin/env bash

# echo "Installing your extensions"
# for line in $(cat "./vscode/extensions"); do
#     code --install-extension --force $line;
# done

echo "Configure settings & keybindings"
dir_name=${0:a:h}
dest_dir=${HOME}/Library/Application\ Support/Code/User
for file in $dir_name/*.json; do
    filename=$(basename $file)
    echo "Configuring $filename"
    if [ -f $dest_dir/$filename ]; then
        mv $dest_dir/$filename $dest_dir/$filename.backup
    fi
    ln -sfn $dir_name/$filename $dest_dir/$filename
done
