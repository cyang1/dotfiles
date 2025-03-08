#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

export ZSH=$HOME/.dotfiles
export VERSION_FILE=$ZSH/.dotfiles-version

# Check for Homebrew
if command -v brew >/dev/null 2>&1
then
  brew update
  brew upgrade
else
  echo "  Installing Homebrew for you."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval $(/opt/homebrew/bin/brew shellenv)
  brew doctor
fi

( cd $ZSH && grep -Fxq $(git rev-parse HEAD) "$VERSION_FILE" 2> /dev/null )
if [ $? -ne 0 ]
then
  # Install homebrew packages
  . $ZSH/homebrew/Brewfile.sh

  ( cd $ZSH && git rev-parse HEAD > "$VERSION_FILE" )
fi
