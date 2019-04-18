#!/bin/bash
function_exists() {
  # declare prints the code of then given function, silence it
  declare -f $1 > /dev/null
  # it returns 1 (failure) if nothing or 0 if found
  echo $?
}

pick_logger() {
  if [ $(function_exists log) -eq 0 ]; then
    echo log
  else
    echo echo
  fi
}

simple_link() {
  # usage simple_link file_name target_path
  # must be used in the directory in which simple_link is called
  local log=$(pick_logger)
  local current=$(pwd)
  local target=$3$2
  if [ -f $target ]; then
    $log warn "Found file $target. Removing..."
    rm $target
  fi
  $log info "Linking $1 to $target"
  ln -s $current/$1 $target
}

directory_link() {
  # usage: folder_link target_dir
  # recursively simlinks the entire directory
  local log=$(pick_logger)
  local target=$1
  local backup=$1_backup
  local base=$(pwd)
  # prepare a clean state
  if [ -d $target ]; then
    $log warn "Found existing folder $target, moving it to $backup..."
    [ -d $backup ] && ($log warn "Removing old backup!" && rm -rf $backup)
    mv $target $backup
  fi
  mkdir $target
  recursive_link $(pwd) $target
}

recursive_link() {
  # usage: recursive_link root_dir target_root_dir
  # must be used first in root_dir
  local log=$(pick_logger)
  for d in *; do
    if [ -d $d ]; then
      mkdir $2/$d
      (cd $d && recursive_link $1/$d $2/$d)
    else
      simple_link $d $2/$d
    fi
  done
}

ROOT=$(pwd)

### BASH ###
cd ./bash
simple_link bashrc ~/.bashrc
source ~/.bashrc # get the better logging func
simple_link bash_profile ~/.bash_profile
cd bash
directory_link ~/.bash
log info "Installing gitawareprompt..."
git clone https://github.com/jimeh/git-aware-prompt.git ~/.bash/git-aware-prompt
# reload again
source ~/.bashrc
cd $ROOT

### INPUTRC ###
simple_link inputrc ~/.inputrc

### VIM ###
cd ./vim
directory_link ~/.vim

# Install vundle
log info "Installing Vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cd $ROOT

log info "All set!"
