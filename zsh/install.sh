#!/usr/bin/env bash

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
curl -L https://iterm2.com/shell_integration/zsh \
-o ~/.iterm2_shell_integration.zsh

# commonrc
cat <<-EOF >> "~/.zshenv"
    source $(dirname ${BASH_SOURCE[0]})/../.commonrc
EOF

# z-files
for file in $(dirname ${BASH_SOURCE[0]})/z*; do
filename=basename $file
cat <<-EOF >> "~/.$filename"
    source $(dirname ${BASH_SOURCE[0]})/$filename
EOF
done

# iTerm
cat <<-EOF >> "~/.zshrc"
    source ~/.iterm2_shell_integration.zsh
EOF
