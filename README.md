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
- lazygit
- ripgrep


Install them like this (If you are on Debian/Ubuntu/LinuxMint)
```bash
apt install rofi tmux zsh git xclip ripgrep

apt install curl && \
mkdir -p ~/bin/programms && \
curl -o ~/bin/programs/ -L "https://github.com/neovim/neovim/releases/download/stable/nvim.appimage" && \
cd ~/bin && ln -s ./programs/nvim.appimage nvim && ln -s nvim vim && \
\
mkdir -p /tmp/lazygitinstall && cd /tmp/lazygitinstall && \
curl -L "https://github.com/jesseduffield/lazygit/releases/download/v0.37.0/lazygit_0.37.0_Linux_x86_64.tar.gz" | tar -xzv && \
cp /tmp/lazygitinstall/lazygit ~/bin/lazygit
```
