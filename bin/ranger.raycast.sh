#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Ranger
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📁 

# Documentation:
# @raycast.description launches Ranger inside Kitty
# @raycast.author Rocco Goßmann
# @raycast.authorURL https://rocco-gossmann.github.io

cd $HOME;
export ZSH_AUTOLAUNCH="ranger";

kitty -1 # --start-as=maximized

