#!/bin/zsh

function oath {
    FILENAME=$1
    (cd ~ && oathtool --totp --base32 "@$FILENAME" | tr -d '\n' | pbcopy )
}
