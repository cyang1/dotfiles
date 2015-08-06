# Install command-line tools using Homebrew

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils
# Install some other useful utilities like `sponge`
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`
brew install gnu-sed --default-names

# Install wget with IRI support
brew install wget --enable-iri

# Install more recent versions of some OS X tools
brew install git
brew install python # Must go before vim
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/screen
brew install zsh

# Install other useful binaries
brew install aria2
brew install cmake
brew install grc
brew install htop-osx
brew install hub
brew install node
brew install p7zip
brew install tmux
brew install watch
