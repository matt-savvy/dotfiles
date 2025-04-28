#!/bin/zsh

function dev_cd {
    DIR=$(cd ~/dev && ls -d * | fzf)

    if [[ $? -eq 0 && -n ~/dev/$DIR ]]; then
        cd ~/dev/$DIR
    fi
}
