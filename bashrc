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
   echo "welcom to omar"
   name=omar
   colordir=/usr/bin/dircolors
   [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
   . ~/.linux_sys_vars
   export PATH="/etc/anaconda/bin:$PATH"
   export MOBY2_PREFIX=$HOME/class/build
   export LDFLAGS="-L$MOBY2_PREFIX/lib $LDFLAGS"
   export CFLAGS="-I$MOBY2_PREFIX/include -I$HOME/local/include $CFLAGS "
   export CPPFLAGS="-I$MOBY2_PREFIX/include -I$HOME/local/include $CPPFLAGS"
   export LDFLAGS="-L$HOME/local/lib $LDFLAGS"
   export PATH=$MOBY2_PREFIX/bin:$PATH
   export PYTHONPATH=$MOBY2_PREFIX/lib64/python2.7/site-packages:$MOBY2_PREFIX/lib/python2.7/site-packages:$HOME/local/lib64/python2.7/site-packages:$HOME/local/lib/python2.7/site-packages:$PYTHONPATH
   export LD_LIBRARY_PATH=$MOBY2_PREFIX/lib64:$MOBY2_PREFIX/lib:$HOME/local/lib:$LD_LIBRARY_PATH
else
   echo "setup of profile and PATH required"
   colordir=/usr/bin/dircolors
fi


#load dircolors
if [ -x "$colordir" ]; then
   test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
