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

export PATH=/home/chris/bin:$PATH:/usr/local/sbin/usr/sbin:/sbin:$HOME/.rbenv/bin:/home/chris/proggies/adt/sdk/tools:/home/chris/proggies/adt/sdk/platform-tools:/home/chris/proggies/adt/sdk/build-tools/23.0.0:/home/chris/.local/bin/:/home/chris/proggies/adt/sdk/tools/bin/

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

# case insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

set implicitcd
setopt no_check_jobs 
unsetopt share_history
unset STY
unsetopt correct_all

HISTSIZE=100000000
SAVEHIST=100000000
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
HISTFILE=~/.zsh_history
export HISTSIZE
export SAVEHIST
export HISTFILE

export GIT_EDITOR=/home/chris/bin/vim
export EDITOR=/home/chris/bin/vim
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
LS_COLORS='rs=0:di=01;36:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=01;36:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS

setopt INC_APPEND_HISTORY
export NODE_PATH=$HOME/unbreak-node:${NODE_PATH}
export TERM=xterm-256color
export CLOUD_CFG=~/cloudcreds.cfg

alias alsamixer='alsamixer -c 0'
alias nvmsh='source ~/bin/nvmsh'
alias apktool='java -jar $HOME/proggies/apktool_2.3.4.jar'

function tmux-x () {
  tmux new-session -t `tmux list-session -F '#{session_name}' | head -1`
}


[ -e $HOME/.secrets ] && source $HOME/.secrets

export PS1='%B%T%b %d %{%}'
autoload -Uz compinit
alias ack-grep="/usr/bin/ack --ignore-file='match:/vendors|bundle.js/'"
alias ack="/usr/bin/ack --ignore-file='match:/vendors|bundle.js|.map/'"
compinit
alias mpv="mpv --no-audio-display"
alias gbr="git branch -r"
alias gij="git status"
gitc() {
  git checkout --track -b $1 origin/$1
}
gitp() {
  git remote update origin --prune
}

export ANDRIOD_NDK_HOME=/home/chris/proggies/android-ndk-r17c/
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/chris/.sdkman"
[[ -s "/home/chris/.sdkman/bin/sdkman-init.sh" ]] && source "/home/chris/.sdkman/bin/sdkman-init.sh"
