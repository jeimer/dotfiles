#if not running interactivley, don't do anything
case $- in
   *i*) ;;
   *) return ;;
esac

############################
#system independend controls
############################

#ingore lines that begin with a space and duplicate command in bash history
HISTCONTROL=ingnoreboth

#append to the history file, don't overwrite it
shopt -s histappend

#check window size and update values of LINES and COLUMNS if window is required
shopt -s checkwinsize

#identify operating system
if [ "$(uname -s)" = "Darwin" ]; then
   OS="OSX"
else
   OS=$(uname -s)
fi

#define shortcut commands based on OS
if [ $OS = "OSX" ]; then
   alias omar="ssh -X eimer@omar.pha.jhu.edu"
   alias ls="gls --color"
   alias dircolors="gdircolors"
   alias ml_env="source ~/Virtualenvs/dato-env/bin/activate"
   alias tree="tree -C"
elif [ $OS = "Linux" ]; then
   alias ls='ls --color'
   alias grep='grep --color'
   alias fgrep='fgrep --color'
   alias egrep='egrep --color'
fi

#ignore lines that begin with a space and duplicate command in bash history
HISTCONTROL=ignoreboth
#check window size after a command and update the values of LINES and COLLUMNS
shopt -s checkwinsize

case "$TERM" in
    xterm-color)
       color_prompt=yes;;
esac

#deterimine computer name and specify computer dependent directories and paths
if [[ "$(uname -n)" == "thenewshoot"* ]]; then
   echo "welcome to thenewshoot"
   name=thenewshoot
   colordir=/usr/local/bin/gdircolors
   PATH=/usr/local/bin:/usr/local/sbin:$PATH
   PYTHONPATH=$PYTHONPATH:/Users/jeimer/Documents/CLASS/optics/python
   export PATH PYTHONPATH
   export PIP_REQUIRE_VIRTUALENV=true  #require virtualenv for pip to run
   [ -x /usr/local/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
elif [ "$(uname -n)" = "omar" ]; then
   echo "welcom to omar"
   name=omar
   colordir=/usr/bin/dircolors
   [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
else
   echo "setup of profile and PATH required"
   colordir=/usr/bin/dircolors
fi


#load dircolors
if [ -x "$colordir" ]; then
   test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

#computer independend alias
alias date="TZ=":US/Eastern" date && date -u"
