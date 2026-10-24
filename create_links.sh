#!/bin/bash

CWD=$(realpath $(dirname $0)) || exit 1
platform_os=$(uname -s)
platform_arch=$(uname -m)

[ "$HOME" == "" ] && echo "no \$HOME - EnvVar" && exit 2

#==============================================================================
# BM: ZSH + TMUX
#==============================================================================
cd $HOME
echo "enter: `pwd`"
ln -s "${CWD}/.zshrc"
ln -s "${CWD}/.zsh"
ln -s "${CWD}/.tmux.conf"

#==============================================================================
# BM: .configs
#==============================================================================
mkdir -p $HOME/.config
cd $HOME/.config
echo "enter: `pwd`"
rm -rf ranger     ; ln -s $CWD/.config/ranger
rm -rf opencode   ; ln -s $CWD/.config/opencode
rm -rf oh-my-posh ; ln -s $CWD/.config/oh-my-posh
rm -rf yazi       ; ln -s $CWD/.config/yazi

#==============================================================================
# BM: VSCodium
#==============================================================================
if [ "$platform_os" = "Linux" ]; then
	mkdir -p $HOME/.config/vscodium/User
	cd $HOME/.config/vscodium/User
	echo "enter: `pwd`"
	rm -f settings.json    ; ln -s $CWD/vscodium/settings.json
	rm -f keybindings.json ; ln -s $CWD/vscodium/keybindings.json keybindings.json

elif [ "$platform_os" = "Darwin" ]; then
	mkdir -p $HOME/Library/Application\ Support/VSCodium/User
	cd $HOME/Library/Application\ Support/VSCodium/User
	echo "enter: `pwd`"
	rm -f settings.json    ; ln -s $CWD/vscodium/settings.json
	rm -f keybindings.json ; ln -s $CWD/vscodium/keybindings.json keybindings.json
	
fi

#==============================================================================
# BM: custom bins
#==============================================================================
mkdir -p $HOME/.local/bin
cd $HOME/.local/bin
echo "enter: `pwd`"
ln -s $CWD/bin/h1
ln -s $CWD/bin/hv
ln -s $CWD/bin/notes
ln -s $CWD/bin/tmux-workspace
ln -s $CWD/bin/projects
ln -s $CWD/bin/projects loc
ln -s $CWD/bin/update-opencode

echo "All done. Some of these need extra depencies. Concider installing:"
echo
echo "fzf ripgrep yazi parallel tmux zsh"
echo
echo "And from external Sources"
echo
echo " - LazyGit"
echo " - Oh-My-POSH"
