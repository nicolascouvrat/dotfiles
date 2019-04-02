#!/bin/bash

VIM_FOLDER=~/.vim
BACKUP_FOLDER=~/vim_backup

# prepare a clean vim folder
if [ -d $VIM_FOLDER ]; then
    echo Found existing $VIM_FOLDER, moving it to $BACKUP_FOLDER...
    # if the backup folder already exists, clean it up
    [ -d $BACKUP_FOLDER ] && (echo WARNING: removing old backup && rm -rf $BACKUP_FOLDER)
    mv $VIM_FOLDER $BACKUP_FOLDER
fi

echo Creating fresh $VIM_FOLDER...
mkdir $VIM_FOLDER

### VIM ###
cd ./vim
base_dir=$(pwd)

# go through the vim directory recursively,
# and creates appropriate simlinks in the ~/.vim folder
recursive_linking() {
    for d in *; do
        local current_dir=$(pwd)
        local relative_dir=${current_dir#$base_dir}
        if [ -d "$d" ]; then
            # if dir, the create folder (otherwise linking will fail)
            mkdir $VIM_FOLDER$relative_dir/$d
            (cd $d && recursive_linking)
        else
            local link_target=$relative_dir/$d
            echo Linking $d to $VIM_FOLDER$link_target
            ln -s $current_dir/$d $VIM_FOLDER$link_target
        fi
    done
}

recursive_linking
# Install vundle
echo Installing Vundle..
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo All set!

### VIM DONE ###
