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
    return
  else
    echo echo
    return
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
  local target=$1
  backup_and_clean $target
  mkdir $target
  recursive_link $(pwd) $target
}

backup_and_clean() {
  local log=$(pick_logger)
  local target=$1
  local backup=$1_backup
  # prepare a clean state
  if [ -d $target ]; then
    $log warn "Found existing folder $target, moving it to $backup..."
    [ -d $backup ] && ($log warn "Removing old backup!" && rm -rf $backup)
    mv $target $backup
  fi
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
# get the logging function
source ./mini_zshrc

### BASH ###
cd ./bash
simple_link bashrc ~/.bashrc
simple_link bash_profile ~/.bash_profile
cd bash
directory_link ~/.bash
log info "Installing gitawareprompt..."
git clone https://github.com/jimeh/git-aware-prompt.git ~/.bash/git-aware-prompt
# reload again
cd $ROOT

### ZSH ###
log info "Installing Oh My ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
log info "Done"

cd ./zsh
simple_link zshrc ~/.zshrc
cd $ROOT

### INPUTRC ###
simple_link inputrc ~/.inputrc
simple_link tmux.conf ~/.tmux.conf

### VIM ###
cd ./vim
directory_link ~/.vim

# Install vundle
log info "Installing Vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cd $ROOT

log info "Installing Jenv..."
backup_and_clean ~/.jenv
git clone https://github.com/jenv/jenv.git ~/.jenv
cd $ROOT
log info "Configuring Jenv..."
jenv enable-plugin export
jenv enable-plugin maven

log info "Installing Pyenv..."
backup_and_clean ~/.pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd $ROOT

log info "Installing tmux..."
brew install tmux

# To make pbcopy work from tmux
log info "Installing reattach-to-user-namespace..."
brew install reattach-to-user-namespace


log info "Installing Dracula Terminal.app theme..."
backup_and_clean ~/dracula-terminal-theme
git clone https://github.com/dracula/terminal-app.git ~/dracula-terminal-theme
log info "To finish setting up terminal colors, go to Terminal > Settings, click gear icon then import Dracula.terminal from $HOME/dracula-terminal-theme"
cd $ROOT

log info "All set! Restart your terminal now :)"
