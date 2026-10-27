#!/bin/bash

# Activate mise
eval "$(mise activate bash)"

export DOTS=$HOME/Projects/github.com/stellarhoof/dots
git clone https://github.com/stellarhoof/dots.git $DOTS
mise bootstrap --yes --cd $DOTS/void
mise bootstrap --yes --cd $DOTS/common

# Import gpg key used to unencrypt passwords
gpg --batch --import store-key.asc

# Trust imported gpg key
fingerprint=$(gpg --batch --with-colons --fingerprint "azure.satellite@gmail.com" | awk -F: '/^fpr/{print $10; exit}')
echo "${fingerprint}:4:" | gpg --batch --import-ownertrust

# Change gnupg permissions to make gpg happy
chown -R $(whoami) ~/.gnupg
chmod 600 ~/.gnupg/*
chmod 700 ~/.gnupg

# Add github's SSH key to ssh agent
mkdir -p ~/.ssh
pass ssh/github.com >~/.ssh/github.com
chmod 600 ~/.ssh/github.com
ssh-add ~/.ssh/github.com

# Change remote origins for my projects
cd ~/Projects/github.com/stellarhoof/dots && git remote set-url origin git@github.com:stellarhoof/dots.git
cd ~/Projects/github.com/stellarhoof/nvim && git remote set-url origin git@github.com:stellarhoof/nvim.git
cd ~/Projects/github.com/stellarhoof/pass && git remote set-url origin git@github.com:stellarhoof/pass.git
