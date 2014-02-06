
# If not running interactively, don't do anything
[ -z "$PS1" ] && return


#-------------------------------------------------------------
# Source global definitions (if any)
#-------------------------------------------------------------

if [ -f /etc/bashrc ]; then
      . /etc/bashrc   # --> Read /etc/bashrc, if present.
fi

if [ -f ~/.private-aliases ]; then
	. ~/.private-aliases
fi

source ~/.liquidprompt/liquidprompt

alias kb-laptop="echo 1 | sudo tee /sys/module/hid_apple/parameters/iso_layout"
alias kb-external="echo 0 | sudo tee /sys/module/hid_apple/parameters/iso_layout"
alias kb-fnmode="echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode"
alias tp-horiz="synclient HorizTwofingerScroll=1"

alias r="cd /"
alias h="cd ~"
alias sites="cd ~/Sites"
alias dev="cd ~/Developer"

# alias s="sudo"
alias ls="ls -lsh --color=always"
alias la="ls -lsha --color=always"
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'''

alias sano="sudo nano"
alias ssublime="sudo sublime"

alias apache-start="sudo service httpd start"
alias apache-restart="sudo service httpd restart"
alias apache-stop="sudo service httpd stop"

alias tomcat-start="sudo -u tomcat /opt/tomcat/bin/startup.sh"
alias tomcat-stop="sudo /opt/tomcat/bin/shutdown.sh"

alias df="df -kTh"
alias t="tail"
alias tf="t -f"
alias c="clear"

# drush
alias d="drush"
alias dcc="d cc all"

# git
alias g="git"
alias gs="g status"
alias ga="g add ."
alias gai="g add -i"
alias gd="g diff"
alias gc="g commit -m"
alias gac="g add .;g commit -m"
alias gp="g push"
alias gb="g branch"
alias gbm="gb -m"
alias ggraph="git log --graph --abbrev-commit --decorate=no --format=format:' %C(bold yellow)%ai%C(reset) %C(yellow)(%ar)%C(reset)%C(auto)%+d%C(reset)%n'' %C(dim white)%an%C(reset)%n'' %C(bold white)%s%C(reset)%n'' %C(blue)%H%C(reset)%n' --all"
alias gr="g remote"
alias grr="gr rename"
alias github="chrome \`git remote -v | grep github.com | grep fetch | head -1 | field 2 | sed 's/git:/http:/g'\`"
alias g_find_rep="find ./ -name .git -type d"
alias g_ignore_filemode="git config core.fileMode false"

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias mount='mount |column -t'

alias open='nautilus . &'

# network
alias my_ips="sudo ip addr show"
#alias find_local_ssh_ips="nmap -T5 -n -p 22 --open --min-parallelism 200 192.168.0.100-200"
alias find_local_ssh_ips="nmap -T5 -n -p 22 --open 192.168.0.100-200"
#alias rpi_ip="arp -a | grep b8:27:eb | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'"

# chmod
alias assets_to_755="sudo find . \( -name '*.js' -o -name '*.css' -o -name '*.jpg' -o -name '*.JPG' -o -name '*.gif' -o -name '*.png' -o -name '*.mp3' -o -name '*.ogg' \) -exec chmod 755 {} \;"

# wifi
# /!\ these are not working any more with mageia4 since m4 not using networkmaneger
#alias wifi_on="sudo rfkill unblock wifi; sudo ifconfig wlan0 up"
#alias wifi_off="sudo ifconfig wlan0 down"
#alias wifi_list="sudo iwlist wlan0 scan|grep ESSID"
#alias wifi_connect="sudo iwcong essid" # add ESSID key s:KEY (KEY in ascii, remove s: to key in HEX)
#alias wifi_get_ip="sudo dhclient wlan0"


#Cree le repertoire et va dedans
function mkcd() {
  mkdir $1 && cd $1
}

function mysql-import() {
  local dbname="${1}"
  local filesrc="${2}"
  
  # echo "Password :"
  stty_orig=`stty -g` # save original terminal setting.
  stty -echo          # turn-off echoing.
  read -p "Password :" passwd         # read the password
  stty $stty_orig     # restore terminal setting.
  echo ""
  mysqladmin -u root -p$passwd drop $dbname
  mysqladmin -u root -p$passwd create $dbname
  echo "Database \"$dbname\" created"
  mysql -u root -p$passwd $dbname < $filesrc
  echo "File \"$filesrc\" imported on database \"$dbname\""
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


# go back x directories
b() {
    str=""
    count=0
    while [ "$count" -lt "$1" ];
    do
        str=$str"../"
        let count=count+1
    done
    cd $str
}

# start recording all terminal IO using "script" command
test "$(ps -ocommand= -p $PPID | awk '{print $1}')" == 'script' || (script -q -f $HOME/Desktop/terminal-recording/$(date -u +%Y-%m-%dT%H:%M:%S).${HOSTNAME:-$(hostname)}.$$.${RANDOM}.log)
~

synclient HorizTwoFingerScroll=1

