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
ln -s $CWD/.config/ranger
ln -s $CWD/.config/opencode
ln -s $CWD/.config/oh-my-posh
ln -s $CWD/.config/ranger

mkdir -p $HOME/.local/bin
cd $HOME/.local/bin
echo "enter: `pwd`"
ln -s $CWD/bin/h1
ln -s $CWD/bin/hv
ln -s $CWD/bin/tmux-workspace
ln -s $CWD/bin/projects
ln -s $CWD/bin/projects loc

echo "All done. Some of these need extra depencies. Concider installing:"
echo
echo "fzf ripgrep ranger parallel tmux zsh"
echo
echo "And from external Sources"
echo
echo " - LazyGit"
echo " - Oh-My-POSH"
