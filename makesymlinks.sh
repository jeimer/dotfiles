#!/bin/bash
#############################
# .make.sh
# This scrip creates symlins from the home directory to any 
# desired dotfiles in ~/dotfiles. 
# Based upon smalleycreative blog post.
#############################

#### Variables

dir=~/dotfiles
olddir=~/dofiles_old
files="emacs profile"

####

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changin to the $dir directory"
cd $dir
echo "...done"

# move existing dotfiles in homedir to dotfiles_old directory, 
# then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

