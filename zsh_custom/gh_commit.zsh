#!/bin/zsh

function gh_commit() {
   REMOTE_URL=`git remote get-url origin`
   TRIMMED_URL=${REMOTE_URL:0:-4}
   COMMIT_HASH=`git rev-parse --short HEAD`

   echo "$TRIMMED_URL/commit/$COMMIT_HASH"
}
