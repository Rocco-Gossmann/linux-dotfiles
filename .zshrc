# ZSH_DISABLE_COMPFIX=

# WARN: this Init-file allows ZSH to automatically start any command by
# by writing it into the ZSH_AUTOLAUNCH Env-Var.
# If you are concerend about this, go to the end of this file and remove
# the last IF block


# ZSH / Terminal config
#==============================================================================
HISTFILE=~/.zshhistory
HISTSIZE=1000
SAVEHIST=1000

setopt notify
unsetopt beep
bindkey -v

# export TERM=xterm-256color
export VISUAL=nvim
export EDITOR=nvim

# Own env-Vars
#==============================================================================
export GOPRIVATE=github.com/rocco-gossmann

# Usefull Aliasses
#==============================================================================
alias ls='ls -G'
alias ll='ls -Glh'
alias la='ls -Galh'
alias dir='ls -Galh'

alias l="f(){ cd \`ls -1A -d \$@*/|fzf\`; unset -f f; }; f"


alias hascmd="f(){ which \$@ 1> /dev/null && echo \"yep\" || echo \"nope\"}; f"
alias myfg="f(){ jobs | grep -e \$@ | xargs | sed -r 's/^\[([0-9]+)\].*$/\1/' ; unset -f f; }; f"
alias fg="ju(){ fg %\`myfg \$@\`; unset -f ju; }; ju"
alias tailf="tf(){ tail -f \$@ | sed -e \"s#\\\\\\\\n#\\n#g\"; unset -f tf }; tf"
alias ta="[[ \"$TMUX\" = \"\" ]] && tmux -u attach || tmux choose-tree"

alias du="du -chd1 2>/dev/null | sort -h -k 1,1"

alias lg=lazygit
alias ldoc=lazydocker
alias vim=nvim
alias vi=nvim
alias pm=passmenu
alias tm="tmux-workspace \"main\""
alias db="nvim -c DBUI"
alias mr="make run"
alias doc="docker compose"

# inject envwars
#==============================================================================
alias orig_ssh=`which ssh`
alias ssh="TERM=xterm-256color orig_ssh"


# small commands to fix varous things, that break on Mac sometimes
#==============================================================================
alias fix-homebrew="sudo chown -R \`whoami\` /opt/homebrew/Cellar/zsh-autocomplete/ /opt/homebrew/Cellar/zsh-autosuggestions /opt/homebrew/share/zsh /opt/homebrew/share/zsh/site-functions /usr/local/Homebrew/completions/zsh /opt/homebrew/share/man"
alias fix-alttab="killall AltTab && open /Applications/AltTab.app"
alias fix-gpg="gpgconf --kill gpg-agent && gpgconf --launch gpg-agent"
alias fix-mac-autoupdate="defaults write com.apple.SoftwareUpdate UserNotificationDate -date \"2090-02-07 23:22:47 +0000\"; defaults write com.apple.SoftwareUpdate MajorOSUserNotificationDate -date \"2090-02-07 23:22:47 +0000\""

# extend $PATH
#==============================================================================
[ -e "/usr/local/go/bin" ] && export PATH="/usr/local/go/bin:$PATH"
[ -e "/opt/homebrew/bin" ] && export PATH="/opt/homebrew/bin:$PATH"
[ -e "/opt/homebrew/sbin" ] && export PATH="/opt/homebrew/sbin:$PATH"
[ -e "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -e "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
[ -e "$HOME/go/bin" ] && export PATH="$HOME/go/bin:$PATH"

# source a bunch of zsh-extensions from Homebrew
#==============================================================================
[ "$HOMEBREW_PREFIX" = "" ] && [ "`hascmd brew`" = "yep" ] && export HOMEBREW_PREFIX=$(brew --prefix)
[ -f $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f $HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh ] && source $HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
[ -f $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# activate autocompletion for apps, that don't activate by default
#==============================================================================
[ "`hascmd tnt`" = "yep" ] && source <(tnt completion zsh)
[ "`hascmd docker`" = "yep" ] && source <(docker completion zsh)
[ "`hascmd gowas`" = "yep" ] && source <(gowas completion zsh)
[ "`hascmd zoxide`" = "yep" ] && source <(zoxide init zsh) && eval "$(zoxide init --cmd cd zsh)"

[ -f "$HOME/.deno/env" ] && source  "$HOME/.deno/env"
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"


# Tweaks
#==============================================================================
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# The following lines were added by compinstall
zstyle ':completion:*' format '%d'
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit -u
# End of lines added by compinstall


if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  # [ "`hascmd oh-my-posh`" = "yep" ] && source <(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/multiverse-neon.omp.json)
  [ "`hascmd oh-my-posh`" = "yep" ] && source <(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/omp.toml)
fi


if [ "$ZSH_AUTOLAUNCH" != "" ]; then
	$ZSH_AUTOLAUNCH
	exit;
fi

