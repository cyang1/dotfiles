#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

export ZSH=$HOME/.dotfiles
export VERSION_FILE=$ZSH/.dotfiles-version

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)" > /tmp/homebrew-install.log
  brew doctor
else
  brew update
  brew upgrade
fi

grep -Fxq $(git rev-parse HEAD) "$VERSION_FILE" 2> /dev/null
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

  if [ -z "$(brew ls --versions ntfs-3g)" ]
  then
    # Setup reading NTFS drives, also installs osxfuse
    brew install ntfs-3g

    # Don't let this update automatically because there are some
    # manual steps required
    brew pin ntfs-3g

    # Replace mount_ntfs with a version that allows writing to NTFS
    sudo mv /sbin/mount_ntfs /sbin/mount_ntfs.orig
    sudo ln -s /usr/local/Cellar/ntfs-3g/*/sbin/mount_ntfs /sbin/mount_ntfs

    # Install osxfuse file system bundle
    sudo /bin/cp -RfX /usr/local/Cellar/osxfuse/*/Library/Filesystems/osxfusefs.fs /Library/Filesystems
    sudo chmod +s /Library/Filesystems/osxfusefs.fs/Support/load_osxfusefs
  fi

  git rev-parse HEAD > "$VERSION_FILE"
fi

exit 0
