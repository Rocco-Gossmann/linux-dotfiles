# ZSH / Terminal config
#============================================================================== 
HISTFILE=~/.zshhistory
HISTSIZE=1000
SAVEHIST=1000
setopt notify
unsetopt beep
bindkey -v

export TERM=xterm-256color
export VISUAL=hx
export EDITOR=hx

# Own env-Vars
#============================================================================== 
export GOPRIVATE=github.com/rocco-gossmann

# Usefull Aliasses
#============================================================================== 
alias ls='ls -G'
alias ll='ls -Glh'
alias la='ls -Galh'
alias dir='ls -Galh'

alias lg=lazygit
alias ldoc=lazydocker
alias dockerc=docker-compose

alias myfg="f(){ jobs | grep -e \$@ | xargs | sed -r 's/^\[([0-9]+)\].*$/\1/' ; unset -f f; }; f"
alias fg="ju(){ fg %\`myfg \$@\`; unset -f ju; }; ju"
alias tailf="tf(){ tail -f \$@ | sed -e \"s#\\\\\\\\n#\\n#g\"; unset -f tf }; tf"
alias ta="[[ \"$TMUX\" = \"\" ]] && tmux -u attach || tmux choose-tree"
alias vim="nvim"
alias vi="nvim"
alias tm="tmux-workspace \"main\""
alias no="note"
alias hascmd="f(){ which \$@ 1> /dev/null && echo \"yep\" || echo \"nope\"}; f"
alias pm="passmenu"
alias db="nvim -c DBUI"
alias mr="make run"

# extend $PATH
#============================================================================== 
[ -e "/usr/local/go/bin" ] && export PATH="/usr/local/go/bin:$PATH"
[ -e "/opt/homebrew/bin" ] && export PATH="/opt/homebrew/bin:$PATH"
[ -e "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -e "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
[ -e "$HOME/go/bin" ] && export PATH="$HOME/go/bin:$PATH"
[ -e "$HOME/.bun/bin" ] && export PATH="$HOME/.bun/bin:$PATH"


# source a bunch of stuff for auto completion
#============================================================================== 
[ -f "$HOME/.deno/env" ] && source  "$HOME/.deno/env"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

[ "`hascmd tnt`" = "yep" ] && source <(tnt completion zsh)
[ "`hascmd docker`" = "yep" ] && source <(docker completion zsh)
[ "`hascmd gowas`" = "yep" ] && source <(gowas completion zsh)
[ "`hascmd zoxide`" = "yep" ] && source <(zoxide init zsh) && eval "$(zoxide init --cmd cd zsh)"






# Tweaks for different terminal emulators
#============================================================================== 
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  # [ "`hascmd oh-my-posh`" = "yep" ] && source <(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/multiverse-neon.omp.json)
  [ "`hascmd oh-my-posh`" = "yep" ] && source <(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/omp.toml)
fi


if [ "$TMUX" = "" ] && [ "$NVIM" = "" ] && [ "$TERM_PROGRAM" = "" ]; then tmux new-session -A -s main; fi
