if [ -d '/usr/texbin' ]
then
    export PATH="/usr/texbin${PATH+:$PATH}"
fi
