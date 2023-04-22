#!/bin/bash

gitcmd=git

br=$(${gitcmd} branch 2> /dev/null| grep -e '^\*' | sed -e 's/^* //' | tr -d '\n')

if [ "$br" = "" ] ; then
    echo $'%F{2}%f%k'
else
    gitstat=$(${gitcmd} status 2> /dev/null)
    changes=$(echo "${gitstat}"| grep 'git add')
    staged=$(echo "${gitstat}"| grep 'stage')
    pushable=$(echo "${gitstat}"|grep 'push')

    if [ "${changes}" != "" ] ; then
        echo $'%K{red}%F{2}%f%k%K{red}%F{black}  '"$br"$'%f%k%F{red}%f'
    elif [ "${staged}" != "" ] ; then
        echo $'%K{yellow}%F{2}%f%k%K{yellow}%F{black}  '"$br"$'%k%F{yellow}%f'
    elif [ "${pushable}" != "" ] ; then
        echo $'%K{blue}%F{2}%f%k%K{blue}%F{black}  '"$br"$'%k%F{blue}%f'
    else
        echo $'%K{green}%F{2}%f%k%K{green}%F{black}  '"$br"$'%k%F{green}%f'
    fi
fi


