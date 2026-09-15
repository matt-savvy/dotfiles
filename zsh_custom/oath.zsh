#!/bin/zsh

function oath {
    FILENAME=$1
    (cat ~/$FILENAME | totp | pbcopy)
}
