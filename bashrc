#if not running interactivley, don't do anything
case $- in
   *i*) ;;
   *) return ;;
esac

############################
#system independent controls
############################

#ingore lines that begin with a space and duplicate command in bash history
HISTCONTROL=ingnoreboth

#append to the history file, don't overwrite it
shopt -s histappend

#check window size and update values of LINES and COLUMNS if window is required
shopt -s checkwinsize

#computer independend alias
alias date="TZ=":US/Eastern" date && date -u"


############################
#system dependent controls
############################

#identify operating system
if [ "$(uname -s)" = "Darwin" ]; then
   OS="OSX"
else
   OS=$(uname -s)
fi

#define shortcut commands based on OS
if [ $OS = "OSX" ]; then
   . ~/.mac_aliases
elif [ $OS = "Linux" ]; then
   . ~/.linux_aliases
fi

#deterimine computer name and specify computer dependent directories and paths
if [[ "$(uname -n)" == "thenewshoot"* ]]; then
   echo "welcome to thenewshoot"
   . ~/.mac_sys_vars
   [ -x /usr/local/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
elif [ "$(uname -n)" = "omar" ]; then
   echo "welcome to omar"
   name=omar
   colordir=/usr/bin/dircolors
   [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
   . ~/.linux_sys_vars
else
   echo "setup of profile and PATH required"
   colordir=/usr/bin/dircolors
fi


#load dircolors
if [ -x "$colordir" ]; then
   test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
