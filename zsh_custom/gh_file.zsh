#!/bin/zsh

function gh_file() {
   REMOTE_URL=`git remote get-url origin`
   TRIMMED_URL=${REMOTE_URL:0:-4}
   COMMIT_ISH=`git rev-parse --abbrev-ref HEAD`

   # do we have a detached head checked out?
   if [[ $COMMIT_ISH == HEAD ]]; then
       COMMIT_ISH=`git rev-parse --short HEAD`
   fi;
   FILEPATH=$1

   # is there a line number in this filepath?
   if test "${FILEPATH#*:}" != $FILEPATH; then
       LINE_NUMBER=${FILEPATH#*:}
       FILEPATH=${FILEPATH%%:*}
       echo "$TRIMMED_URL/blob/$COMMIT_ISH/$FILEPATH#L$LINE_NUMBER"
   else
       echo "$TRIMMED_URL/blob/$COMMIT_ISH/$FILEPATH"
   fi
}
