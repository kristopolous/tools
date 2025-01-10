# expand-or-complete-or-list-files
function expand-or-complete-or-list-files() {
    if [[ $#BUFFER == 0 ]]; then
        BUFFER="ls "
        CURSOR=3
        zle list-choices
        zle backward-kill-word
    else
        zle expand-or-complete
    fi
}

export PATH=$HOME/.local/bin:/home/chris/Android/Sdk/platform-tools/:/home/chris/bin:/usr/local/bin/:$PATH:/usr/local/sbin/usr/sbin:/sbin:$HOME/.rbenv/bin:/home/chris/proggies/adt/sdk/tools:/home/chris/proggies/adt/sdk/platform-tools:/home/chris/.local/bin/:/home/chris/proggies/adt/sdk/tools/bin/:/home/chris/node_modules/.bin/:~/code/ghub/music-explorer/tools/:/home/chris/proggies/google-cloud-sdk/bin

unsetopt completeinword
setopt nohup
setopt glob_complete
setopt EXTENDEDGLOB

zle -N expand-or-complete-or-list-files

# bind to tab
bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^I' expand-or-complete-or-list-files
setopt autocd

set implicitcd
setopt no_check_jobs 
unsetopt share_history
unset STY
unsetopt correct_all

setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
HISTSIZE=100000000
SAVEHIST=100000000
HISTFILE=~/.zsh_history
export HISTSIZE
export SAVEHIST
export HISTFILE

export GIT_EDITOR=/usr/bin/vim
export EDITOR=/usr/bin/vim
export JAVA_HOME=/usr/lib/jvm/default-java/

setopt INC_APPEND_HISTORY
export ANDROID_SDK_ROOT=/home/chris/Android/Sdk

alias alsamixer='alsamixer -c 0'
alias nvmsh='source ~/bin/nvmsh'

[ -e $HOME/.secrets ] && source $HOME/.secrets

export PS1='%B%T%b %d %{%}'
autoload -Uz compinit
# case insensitive tab completion
#zstyle ':completion:*' completer _expand
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-suffixes zstyle ':completion:*' expand prefix suffix 

alias ack-grep="/usr/bin/ack --ignore-file='match:/vendors|bundle.js/'"
alias ack="/usr/bin/ack --ignore-file='match:/vendors|bundle.js|.map/'"
compinit
alias gbr="git branch -r"
alias gij="git status"
alias mpv="mpv --no-audio-display"
alias less="/usr/bin/less -r"
gitc() {
  git checkout --track -b $1 origin/$1
}
gitp() {
  git remote update origin --prune
}

MPV_EXEC=/usr/bin/mpv

function tmux-x () {
  tmux new-session -t `tmux list-session -F '#{session_name}' | head -1`
}

function mpv_ {
  $MPV_EXEC --term-status-msg $'\n\e]0;${filename} - mpv\a\n${?pause==yes:(Paused) }${time-pos} / ${duration} (${percent-pos}%)' $@
}

# include | in the kill
backward-kill-space-word () {
  local WORDCHARS=${WORDCHARS/\/}\|
  zle backward-kill-word
}
zle -N backward-kill-space-word
bindkey '^W' backward-kill-space-word

tp() {
  mpv --ao=null $( ~/code/ghub/tube-get/tube-get.py $1 )
}
trim() {
  sed -E 's/^\s+//g;s/\s+$//g'
}
# drop out the /etc/hosts from auto complete
zstyle -e ':completion:*:hosts' hosts 'reply=(
  ${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) 2>/dev/null)"}%%[#| ]*}//,/ }
  ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2>/dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'

export JDK_HOME=/home/chris/jdk/jdk-21.0.5+11/
PATH=/home/chris/jdk/jdk-21.0.5+11/bin:$PATH:$HOME/code/music-explorer/tools
alias cal="ncal -3b"
source $HOME/.local/zsh/zsh-window-title.zsh
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

