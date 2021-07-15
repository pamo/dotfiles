#!/usr/bin/env bash

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set Xterm/screen/Tmux title with only a short hostname.
# Unomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
export SHORT_HOSTNAME=$(hostname -s)

export PATH="/usr/local/opt/libxslt/bin:$PATH"
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export GEM_HOME="$HOME/.gem"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
