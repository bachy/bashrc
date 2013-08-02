
# If not running interactively, don't do anything
[ -z "$PS1" ] && return


#-------------------------------------------------------------
# Source global definitions (if any)
#-------------------------------------------------------------

if [ -f /etc/bashrc ]; then
      . /etc/bashrc   # --> Read /etc/bashrc, if present.
fi

source ~/Developer/BASH/liquidprompt/liquidprompt

alias kb-laptop="echo 1 | sudo tee /sys/module/hid_apple/parameters/iso_layout"
alias kb-external="echo 0 | sudo tee /sys/module/hid_apple/parameters/iso_layout"

alias s="sudo"
alias ls="ls -lsh --color=always"
alias la="ls -lsha --color=always"
alias df="df -kTh"
alias sano="sudo nano"
alias t="tail"
alias tf="t -f"


alias d="drush"
alias dcc="d cc all"

alias g="git"
alias gs="g status"
alias ga="g add -i"
alias gd="g diff"
alias gc="g commit"
alias gp="g push"

alias github="chromium \`git remote -v | grep github.com | grep fetch | head -1 | field 2 | sed 's/git:/http:/g'\`"


#Cree le repertoire et va dedans
function mkcd() {
  mkdir $1 && cd $1
}

# Find a file with a pattern in name - dans le rep local:
function ff() { find . -type f -iname '*'$*'*' -ls ; }

# Find a file with a pattern in name - dans /:
function ffslash() { sudo find / -type f -iname '*'$*'*' -ls ; }

# gojo - tries to unarchive anything thrown at it
function gojo() {
  ##### Probably done more robustly with file(1) but not as easily
  local FILENAME="${1}"
  local FILEEXTENSION=`echo ${1} | cut -d. -f2-`
  case "$FILEEXTENSION" in
    tar)
      tar xvf "$FILENAME";;
    tar.gz)
      tar xzvf "$FILENAME";;
    tgz)
      tar xzvf "$FILENAME";;
    gz)
      gunzip "$FILENAME";;
    tbz)
      tar xjvf "$FILENAME";;
    tbz2)
      tar xjvf "$FILENAME";;
    tar.bz2)
      tar xjvf "$FILENAME";;
    tar.bz)
      tar xjvf "$FILENAME";;
    bz2)
      bunzip2 "$FILENAME";;
    tar.Z)
      tar xZvf "$FILENAME";;
    Z)
      uncompress "$FILENAME";;
    zip)
      unzip "$FILENAME";;
    rar)
      unrar x "$FILENAME";;
  esac
}
