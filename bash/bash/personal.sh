export GOPATH=~/go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin

export M2_HOME=/usr/share/maven
export M2=$M2_HOME/bin
export PATH=$PATH:$M2:$M2_HOME

# Auto add ssh key and do it only once after each reboot
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add
