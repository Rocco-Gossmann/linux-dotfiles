if [[ ":$FPATH:" != *":/Users/st/completions:"* ]]; then export FPATH="/Users/st/completions:$FPATH"; fi
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="jonathan"

plugins=( 
    git
    dnf
    zsh-interactive-cd
)

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
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
alias ta="[[ \"$TMUX\" = \"\" ]] && tmux -u attach || tmux choose-tree"  
alias vim="nvim"
alias vi="nvim"
alias tm="tmux-workspace \"main\""
alias no="note"
alias hascmd="f(){ which \$@ 1> /dev/null && echo \"yep\" || echo \"nope\"}; f"
alias dockerc=docker-compose
alias pm="passmenu"


HISTFILE=~/.zshhistory
HISTSIZE=1000
SAVEHIST=1000
setopt notify
unsetopt beep
bindkey -v

[ -e "/opt/homebrew/bin" ] && export PATH="/opt/homebrew/bin:$PATH"

[ -e "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
[ -e "$HOME/go/bin" ] && export PATH="$HOME/go/bin:$PATH"
[ -e "$HOME/.bun/bin" ] && export PATH="$HOME/.bun/bin:$PATH"

[ "`hascmd tnt`" = "yep" ] && source <(tnt completion zsh)
[ "`hascmd docker`" = "yep" ] && source <(docker completion zsh)
[ "`hascmd gowas`" = "yep" ] && source <(gowas completion zsh)

GOPRIVATE=github.com/rocco-gossmann

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

autoload -Uz compinit
compinit

if [ "$TMUX" = "" ] && [ "$NVIM" = "" ]; then tmux new-session -A -s main; fi
