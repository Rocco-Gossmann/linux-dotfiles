#!/bin/bash

CWD=$(realpath $(dirname $0)) || exit 1

[ "$HOME" == "" ] && echo "no \$HOME - EnvVar" && exit 2

cd $HOME
echo "enter: `pwd`"
ln -s "${CWD}/.zshrc"
ln -s "${CWD}/.zsh"
ln -s "${CWD}/.tmux.conf"

mkdir -p $HOME/.config
cd $HOME/.config
echo "enter: `pwd`"
# rm -rf ghostty    ; ln -s $CWD/.config/ghostty
rm -rf ranger     ; ln -s $CWD/.config/ranger
rm -rf opencode   ; ln -s $CWD/.config/opencode
rm -rf oh-my-posh ; ln -s $CWD/.config/oh-my-posh
# rm -rf ranger     ; ln -s $CWD/.config/ranger
rm -rf yazi       ; ln -s $CWD/.config/yazi

# cd $HOME/.config/ghostty
# echo "enter: `pwd`"
# ln -s $CWD/Bilder/wallpapers/bsp_3x2_conv_16x9_terminal.png ghosttybg-symlink

mkdir -p $HOME/.local/bin
cd $HOME/.local/bin
echo "enter: `pwd`"
ln -s $CWD/bin/h1
ln -s $CWD/bin/hv
ln -s $CWD/bin/notes
ln -s $CWD/bin/tmux-workspace
ln -s $CWD/bin/projects
ln -s $CWD/bin/projects loc

echo "All done. Some of these need extra depencies. Concider installing:"
echo
echo "fzf ripgrep yazi parallel tmux zsh"
echo
echo "And from external Sources"
echo
echo " - LazyGit"
echo " - Oh-My-POSH"
