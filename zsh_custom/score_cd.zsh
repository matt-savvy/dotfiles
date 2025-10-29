#!/bin/zsh

function score_cd {
    DIR=$(fd . -d 1 -t d --threads 1 --format {/} ~/penn-interactive | fzf)

    if [[ -n "$DIR" ]]; then
        cd ~/penn-interactive/$DIR
    fi
}
