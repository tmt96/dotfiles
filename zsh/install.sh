#!/usr/bin/env zsh

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
curl -L https://iterm2.com/shell_integration/zsh \
-o ~/.iterm2_shell_integration.zsh

	cat <<-EOF >> "~/.zshenv"

	source $(pwd)${RELATIVE_FILENAME}${QUOTE}
	EOF
