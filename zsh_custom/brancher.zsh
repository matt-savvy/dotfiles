#!/bin/zsh

function brancher {
    BRANCH_NAME=`git branch $* | fzf`
    BRANCH_NAME=`echo ${BRANCH_NAME/\*/} | tr -d '[:space:]'`

    git checkout $BRANCH_NAME
}

function tagger {
    TAG_NAME=$(git tag --list $* | fzf)

    git checkout $TAG_NAME
}

function git_next {
    NEXT_COMMIT=$(git rev-list --reverse HEAD..$1 | head -n 1)

    git checkout $NEXT_COMMIT
}
