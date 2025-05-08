#!/bin/zsh

function dev_cd {
    DIR=$(fd . -d 1 -t d --threads 1 --format {/} ~/dev | fzf)

    if [[ $? -eq 0 && -n ~/dev/$DIR ]]; then
        cd ~/dev/$DIR
    fi
}
