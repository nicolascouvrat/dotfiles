export PATH=$PATH:/usr/local/go/bin

# Auto add ssh key and do it only once after each reboot
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add
