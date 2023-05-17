#!/bin/zsh

function brancher {
    BRANCH_NAME=`git branch $* | fzf`
    BRANCH_NAME=`echo ${BRANCH_NAME/\*/} | tr -d '[:space:]'`

    git checkout $BRANCH_NAME
}
