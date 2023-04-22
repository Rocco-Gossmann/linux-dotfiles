# linux-dotfiles
The bare minimum required for setting a fresh home directory

Requires to following apps to be installed:
- rofi
- xclip
- git
- zsh
- neovim 0.9+
- tmux
- curl

```bash
apt install rofi tmux zsh git xclip

apt install curl && curl -o ~/bin/programs/ -L "https://github.com/neovim/neovim/releases/download/stable/nvim.appimage" && cd ~/bin && ln -s ./programs/nvim.appimage nvim && ln -s nvim vim
```
