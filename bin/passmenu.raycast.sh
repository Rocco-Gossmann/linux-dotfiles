#!/usr/bin/env zsh -i

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title PasswordMenu
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔐

# Documentation:
# @raycast.description Opens the `pass` Selector. Based on the `pass` and `choice` shell scripts
# @raycast.author Rocco Goßmann
# @raycast.authorURL https://rocco-gossmann.github.io

export PATH=$PATH:$HOME/.local/bin
export ZSH_AUTOLAUNCH="passmenu";

kitty -1 # --start-as=maximized

exit;

