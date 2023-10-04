#!/bin/zsh

function gh_file() {
   REMOTE_URL=`git remote get-url origin`
   TRIMMED_URL=${REMOTE_URL:0:-4}
   COMMIT_ISH=`git rev-parse --abbrev-ref HEAD`
   FILEPATH=$1

   echo "$TRIMMED_URL/blob/$COMMIT_ISH/$FILEPATH"
}
