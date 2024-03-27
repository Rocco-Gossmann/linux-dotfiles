# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="jonathan"

plugins=( 
    git
    dnf
    zsh-interactive-cd
)

source $ZSH/oh-my-zsh.sh

# export TERM=xterm-256color

export VISUAL=nvim
export EDITOR=nvim

alias ll='ls -Glh'
alias la='ls -Galh'
alias dir='ls -Galh'

alias lg=lazygit
alias cf='cd "`ff`"'

alias myfg="f(){ jobs | grep -e \$@ | xargs | sed -r 's/^\[([0-9]+)\].*$/\1/' ; unset -f f; }; f"
alias fg="ju(){ fg %\`myfg \$@\`; unset -f ju; }; ju"
alias tailf="tf(){ tail -f \$@ | sed -e \"s#\\\\\\\\n#\\n#g\"; unset -f tf }; tf"
alias ta="tmux attach"
alias code="codium"
alias vim="nvim"
alias vi="nvim"
alias tm="tmux-workspace \"main\""


HISTFILE=~/.zshhistory
HISTSIZE=1000
SAVEHIST=1000
setopt notify
unsetopt beep
bindkey -v


export PATH="/home/rocco/.local/bin:$PATH"
export PATH="/home/rocco/DEV/1_workspace/GoLang/tnt:$PATH"
source <(tnt completion zsh)

# if [ "$TMUX" = "" ] && [ "$NVIM" = "" ]; then tmux new-session -A -s main; fi
# check the dnf plugins commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dnf


# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r


### From this line is for pywal-colors
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
#(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
#cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
#source ~/.cache/wal/colors-tty.sh



