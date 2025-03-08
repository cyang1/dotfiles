if [ -d '/opt/homebrew' ]
then
    export HOMEBREW_PREFIX="/opt/homebrew";
    export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar";
    export HOMEBREW_REPOSITORY=$HOMEBREW_PREFIX;

    # First put `brew` on the path.
    export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin${PATH+:$PATH}"

    # Now update the remainder.
    export PATH="$(brew --prefix gnu-sed)/libexec/gnubin:$(brew --prefix coreutils)/libexec/gnubin${PATH+:$PATH}"
    export MANPATH="$(brew --prefix gnu-sed)/libexec/gnuman:$(brew --prefix coreutils)/libexec/gnuman:$HOMEBREW_PREFIX/share/man${MANPATH+:$MANPATH}"
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
fi
