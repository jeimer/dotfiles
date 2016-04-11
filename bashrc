#if not running interactivley, don't do anything
case $- in
   *i*) ;;
   *) return ;;
esac

#identify operating system
if [ "$(uname -s)" = "Darwin" ]; then
   OS="OSX"
else
   OS=$(uname -s)
fi

#define shortcut commands based on OS
if [ $OS = "OSX" ]; then
   alias omar="ssh -X eimer@omar.pha.jhu.edu"
   alias ls="gls --color=auto"
   alias dircolors="gdircolors"
elif [ $OS = "Linux" ]; then
   alias ls='ls --color=auto'
   alias grep='grep --color=auto'
   alias fgrep='fgrep --color=auto'
   alias egrep='egrep --color=auto'
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
if [ "$(uname -n)" = "omar" ]; then
   echo "welcome to omar"
   name=omar
   colordir=/usr/bin/dircolors
elif [[ "$(uname -n)" == "thenewshoot"* ]]; then
   echo "welcome to thenewshoot"
   name=thenewshoot
   colordir=/usr/local/bin/gdircolors
   #export CLICOLOR=1
   #export LSCOLORS=ExFxBxDxCxegedabagacad
   PATH=/usr/local/bin:/usr/local/sbin:$PATH
   PYTHONPATH=$PYTHONPATH:/Users/jeimer/Documents/CLASS/optics/python
   export PATH PYTHONPATH
else
   colordir=/usr/bin/dircolors
fi


#load dircolors
if [ -x "$colordir" ]; then
   echo "colordir works"
   test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

#load ls_colors
#if [ -f "$HOME/.ls_colors" ]; then
#   . $HOME/.ls_color;
#fi

alias date="TZ=":US/Eastern" date && date -u"
alias ml_env="source ~/Virtualenvs/dato-env/bin/activate"

#require virtualenv for pip to run
export PIP_REQUIRE_VIRTUALENV=true
