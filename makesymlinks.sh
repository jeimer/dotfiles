#!/bin/bash
#############################
# .make.sh
# This scrip creates symlins from the home directory to any 
# desired dotfiles in ~/dotfiles. 
# Based upon smalleycreative blog post.
#############################

#### Variables

dir=$HOME/dotfiles
olddir=$HOME/dotfiles_old
files="emacs bashrc profile mac_aliases linux_aliases dircolors"

###

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move existing dotfiles in homedir to dotfiles_old directory, 
# then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv $HOME/.$file $HOME/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file $HOME/.$file
done
