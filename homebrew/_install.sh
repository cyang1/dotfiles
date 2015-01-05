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
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)" > /tmp/homebrew-install.log
  brew doctor
fi

( cd $ZSH && grep -Fxq $(git rev-parse HEAD) "$VERSION_FILE" 2> /dev/null )
if [ $? -ne 0 ]
then
  # Install homebrew packages
  brew bundle $ZSH/homebrew/Brewfile

  # Now, checkout an older version of Vim (7.4.253) to build with client server
  # since only LaTeX really needs it and I don't want to run X11 all the time
  if [ ! -e "$(brew --cellar vim)/7.4.253" ]
  then
    # First, unlink normal vim
    brew unlink vim

    ( cd $(brew --prefix) && \
      git checkout 0541807 $(brew --prefix)/Library/Formula/vim.rb && \
      { brew install vim --with-client-server && brew unlink vim; \
        git checkout HEAD $(brew --prefix)/Library/Formula/vim.rb; } )

    # Now relink normal vim
    brew link vim
  fi

  ( cd $ZSH && git rev-parse HEAD > "$VERSION_FILE" )
fi
