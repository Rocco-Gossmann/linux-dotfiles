#!/bin/bash

gitcmd=git

br=$(${gitcmd} branch 2> /dev/null| grep -e '^\*' | sed -e 's/^* //' | tr -d '\n')

if [ "$br" = "" ] ; then
    echo $'%k%f'
else
    gitstat=$(${gitcmd} status 2> /dev/null)
    changes=$(echo "${gitstat}"| grep 'git add')
    staged=$(echo "${gitstat}"| grep 'stage')
    pushable=$(echo "${gitstat}"|grep 'push')
    pullable=$(echo "${gitstat}"|grep 'pull')

    if [ "${changes}" != "" ] ; then
        echo $'%K{red}%F{white}  '"$br"$' %k%F{red}%f'
    elif [ "${staged}" != "" ] ; then
        echo $'%K{yellow}%F{black}  '"$br"$' %k%F{yellow}%f'
    elif [ "${pushable}" != "" ] ; then
        echo $'%K{blue}%F{black}  '"$br"$' %k%F{blue}%f'
    elif [ "${pullable}" != "" ] ; then
        echo $'%K{white}%F{black}  '"$br"$' %k%F{white}%f'
    else
        echo $'%K{green}%F{black}  '"$br"$' %k%F{green}%f'
    fi
fi
echo $'%(!./!\.---)> '


