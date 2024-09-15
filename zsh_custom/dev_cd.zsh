#!/bin/zsh

function dev_cd {
    DIR=$(find ~/dev -maxdepth 1 -type d -printf "%P\n" | fzf)

    if [[ -n ~/dev/$DIR ]]; then
        cd ~/dev/$DIR
    fi
}
