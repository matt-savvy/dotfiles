#!/bin/zsh

function score_cd {
    DIR=`cd ~ && ls -d scorebet/*/ scoremedia/*/ | fzf`

    if [[ -n "$DIR" ]]; then
        cd ~/$DIR
    fi
}
