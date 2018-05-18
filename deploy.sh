#!/bin/bash
# This script creates simlinks for dotfiles

dir=~/dotfiles
files="vimrc"
backup=~/dotfiles_backup

# create a backup
mkdir -p $backup

for file in $files; do
	if [ -f ~/.$file ]; then
		echo "Found existing .$file, moving to $backup"
		mv ~/.$file $backup/
	fi
	echo "Creating simlink to $file in home directory."
	ln -s $dir/$file ~/.$file
done
