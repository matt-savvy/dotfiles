#!/bin/zsh

function git_branch {
    BRANCH_NAME=`git rev-parse --abbrev-ref HEAD`

    echo $BRANCH_NAME | tr -d '\n' | pbcopy
}
