# Install command-line tools using Homebrew

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils
# Install some other useful utilities like `sponge`
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`
brew install gnu-sed --with-default-names

# Install wget with IRI support
brew install wget --with-iri

# Install more recent versions of some OS X tools
brew install git
brew install grep
brew install screen
brew install zsh

# Install other useful binaries
brew install aria2
brew install cmake
brew install grc
brew install htop-osx
brew install hub
brew install node
brew install p7zip
brew install python3
brew install tmux
brew install watch

# Neovim and Python plugin
brew install neovim
python3 -mpip install pynvim

# File utilities
brew install bat
brew install fzf
brew install git-delta
brew install ripgrep

# Force link the new git
brew link --overwrite git

# Add the new zsh to /etc/shells and change the shell to zsh
sudo bash -c 'grep -qF /usr/local/bin/zsh /etc/shells || echo /usr/local/bin/zsh >> /etc/shells'
sudo bash -c 'chsh -s /usr/local/bin/zsh $SUDO_USER'
