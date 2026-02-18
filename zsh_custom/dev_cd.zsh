#!/bin/zsh

function dir_picker {
    BASE_DIR=$1
    DIR=$(fd . -d 1 -t d --threads 1 --format {/} $BASE_DIR | fzf)

    if [[ $? -eq 0 && -n $BASE_DIR/$DIR ]]; then
        cd $BASE_DIR/$DIR
    fi
}

function dev_cd {
    dir_picker ~/dev
}

function stord_cd {
    dir_picker ~/stordco
}
