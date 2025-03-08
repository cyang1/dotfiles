# Install command-line tools using Homebrew

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils
# Install some other useful utilities like `sponge`
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils
brew install gnu-sed
brew install wget

# Install more recent versions of some OS X tools
brew install git
brew install grep
brew install screen

# Install other useful binaries
brew install grc
brew install htop-osx
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

# Change the shell to system zsh
sudo bash -c 'chsh -s /bin/zsh $SUDO_USER'
