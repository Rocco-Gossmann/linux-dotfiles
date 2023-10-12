# Lines configured by zsh-newuser-install
#cd $HOME

HISTFILE=~/.zshhistory
HISTSIZE=1000
SAVEHIST=1000
setopt notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
setopt PROMPT_SUBST
# %B ... %b = start stop using bold text
# %F ... %f = Forground Color same scheme as with %B ... %b
# %K ... %k = Background Color same scheme as with %B ... %b
#
# %m name of the Computer
export PS1=$'%B%K{5}%F{7} %D %T %b%K{6}%F{5} %F{black} %~ %F{6}%k$(__git_ps1.sh)'
# export PS1=$'%B%K{5}%F{7} %T %f%k%b%K{6}%F{5} %f%k%K{6}%F{black}%m %k%K{2}%F{6} %f%k%K{green}%F{black} %~ %k%f$(__git_ps1.sh)'

export PATH=$PATH:~/bin:/usr/local/go/bin

#  set terminal to 256 Color Mode
export TERM=xterm-256color

export VISUAL=codium
export EDITOR=codium

alias ll='ls -Glh'
alias la='ls -Galh'
alias dir='ls -Galh'

alias lg=lazygit
alias cf='cd "`ff`"'

alias myfg="f(){ jobs | grep -e \$@ | xargs | sed -r 's/^\[([0-9]+)\].*$/\1/' ; unset -f f; }; f"
alias fg="ju(){ fg %\`myfg \$@\`; unset -f ju; }; ju"
alias tailf="tf(){ tail -f \$@ | sed -e \"s#\\\\\\\\n#\\n#g\"; unset -f tf }; tf"
alias ta="tmux attach"
alias mc="ranger"
alias code="codium"
alias vim="nvim"
alias vi="nvim"

source $HOME/.zsh/zsh-vi-mode.plugin.zsh

# xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $(xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}')
if [ "$TMUX" = "" ] && [ "$NVIM" = "" ]; then tmux new-session -A -s main; fi
