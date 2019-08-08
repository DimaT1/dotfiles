## Zsh configuration file.

stty -ixon

## Variables by default
[ -z "$PAGER" ] && export PAGER=less
[ -z "$EDITOR" ] && export EDITOR=nvim
#export SHELL=/usr/bin/zsh
export TERM=st-256color

HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=1000
setopt appendhistory extendedglob
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/dim/.zshrc'

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=4'
bindkey '^ ' autosuggest-accept
autoload -U zcalc

autoload -Uz compinit
compinit
# End of lines added by compinstall

bindkey -v

# Remove mode switching delay.
KEYTIMEOUT=5

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# Use beam shape cursor for each new prompt.
preexec() {
   echo -ne '\e[5 q'
}

alias ls='ls --color=auto --group-directories-first'
alias ccat="highlight --out-format=ansi"
alias vi="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


autoload -U colors && colors

alias v="$EDITOR"
alias r="ranger"
alias vf="/home/dim/.config/vifm/scripts/vifmrun"
alias p3="python3"
alias p="python3"
alias p3i="pip3 install"
alias sv="source venv/bin/activate"
alias we="~/.config/i3/connect_wifi.sh"
alias x="sxiv"
alias m="make"
alias mcl="make clean"
alias rf="rifle"
alias pig="ping google.com"

alias male="make"
alias sl="ls"
alias ды="ls"
alias :q="exit"

alias g="git"
alias ga="git add"
alias gs="git status"
alias gc="git commit"
alias gcl="git clone"
alias gpo='git push origin'
alias gpl='git pull'
alias gch="git checkout"
alias gd="git diff"
alias gr="git reset"
alias grhh="git reset --hard HEAD"

alias tn='tmux new-session -s'
alias ta='tmux attach -t'
alias tnd='tmux new-session -s develop'
alias tad='tmux attach -t develop'
alias ka="killall"
alias mkd="mkdir -pv"
alias tch="touch"
alias cls="clear"
alias hg="history | grep"

alias gr="go run"
alias gt="go test"

alias sc="shellcheck"
# alias docker="sudo docker"

alias meh='sudo $(history -p !!)'
                          
alias cd..='cd ..'
alias ~='cd ~'

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'           
               
alias .2='cd ../../'                                      
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
                
alias dtp="xinput --disable 11"
alias etp="xinput --enable 11"


## Setting prompt.
autoload -U colors && colors
#export PROMPT="%0(?..[%{$fg[yellow]%}%?%{$reset_color%}] )%{$fg[red]%}%n%{$reset_color%}@%{$fg[cyan]%}%M%{$reset_color%} %~ %{$fg[red]%}%0(#.#.$)%{$reset_color%} "
PROMPT='%{$fg[black]$bg[white]%} %n %{$fg[grey]$bg[blue]%} $(pwd | sed 's!/home/dim!~!') %0(?..%{$fg[black]$bg[red]%} %?%] )%{$reset_color%}  '
 
## Copied part for git
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
            '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f'
zstyle ':vcs_info:*' formats       \
            '%F{5}[%F{2}%b%F{5}]%f'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git cvs svn
vcs_info_wrapper() {
        vcs_info
        if [ -n "$vcs_info_msg_0_" ]; then
                echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
        fi
}
 
if [ -z "$NO_RPROMPT" ]; then
    RPROMPT=$'$(vcs_info_wrapper)'
fi
 
## Stabilizing title && thin mode prompt
case $TERM in
    xterm*)
        precmd() {
            print -Pn "\e]0;$(whoami) @ $(hostname)\a"
            #[ $(($(tput cols) < 50)) = 0 ] || print -n "\n=> "
        }
        ;;
esac

# setxkbmap -model pc105 -layout us,ru -option grp:alt_shift_toggle

