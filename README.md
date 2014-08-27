# cyang1 does dotfiles

## dotfiles

Your dotfiles are how you personalize your system. These are mine.

These are dotfiles forked from [Zach Holman](http://github.com/holman) and
modified to suit my needs. There have been a couple bug fixes and additional
features, along with many personal customizations. Most of the text in this
README is from [Holman's original README](http://github.com/holman/dotfiles).

## install

Run this:

```sh
git clone https://github.com/cyang1/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
script/install
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

`dot` is a simple script that installs some dependencies, sets sane OS X
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.

Additionally, you can run `brew bundle homebrew/Caskfile` if you want to install
native apps using homebrew. This is optional, however, because cask does not
detect duplicate applications installed using alternative methods.

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there.

Anything with an extension of `.zsh` will get automatically included into your
shell if it does not have `.ignore` anywhere in its path. Anything with an
extension of `.symlink` will get symlinked without extension into `$HOME` and
prefixed with a `.` when you run `script/bootstrap`.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.ignore/\***: Any files ending in `.zsh` that are children if a
  directory suffixed with `.ignore` will be ignored.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/install.sh**: Any file named `install.sh` is run when
  `./script/install` is called.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.
