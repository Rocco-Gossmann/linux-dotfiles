# linux-dotfiles
The bare minimum required for setting a fresh home directory

Requires to following apps to be installed:
- curl
- xclip
- git
- zsh
- neovim 0.9+
- tmux
- curl
- lazygit
- ripgrep
- ranger
- pass
- moreutils-parallel
- fzf

Install them like this (If you are on Debian/Ubuntu/LinuxMint)
```bash
sudo apt install curl tmux zsh git xclip ripgrep ranger pass gpg moreutils.parallel fzf

mkdir -p ~/bin/programs

sudo apt install curl && \
curl -o ~/bin/programs/nvim.appimage -L "https://github.com/neovim/neovim/releases/download/stable/nvim.appimage" && \
chmod +x ~/bin/programs/nvim.appimage && \
cd ~/bin && ln -s ./programs/nvim.appimage nvim && ln -s nvim vim && ln -s nvim vi \
\
mkdir -p /tmp/lazygitinstall && cd /tmp/lazygitinstall && \
curl -L "https://github.com/jesseduffield/lazygit/releases/download/v0.37.0/lazygit_0.37.0_Linux_x86_64.tar.gz" | tar -xzv && \
cp /tmp/lazygitinstall/lazygit ~/bin/lazygit
```

# Optional
- i3 
- i3status
- feh
- compton

```bash
sudo apt install i3 i3status i3 feh compton
```
