#!/bin/bash

# Activate mise
eval "$(mise activate bash)"

export DOTS=$HOME/Projects/github.com/stellarhoof/dots
git clone https://github.com/stellarhoof/dots.git $DOTS
mise bootstrap --yes --cd $DOTS/common
mise bootstrap --yes --cd $DOTS/void
