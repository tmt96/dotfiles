#!/usr/bin/env zsh

echo
echo "Syncing your git config..."

dir_name=${0:a:h}
source $dir_name/../function.sh

git config --global include.path gitalias.txt

# for file in $dir_name/git*; do
#     filename="$(basename $file)"
#     echo "Configuring .$filename"
#     test -f ${HOME}/."$filename" || touch ${HOME}/."$filename"
#     if ! grep "$file" ${HOME}/."$filename" > /dev/null 2>&1; then
#         echo "source $file" >>  ${HOME}/."$filename"
#     fi
# done

echo "Done configuring git!!"
echo