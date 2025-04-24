#!/bin/zsh

function mix_test() {
  QUERY=$1
  TEST_DIRS=$2

  # no query
  if [[ -z $QUERY ]]; then
    mix test
    return $?
  fi

  # query begins with test/
  # if $1 starts with test, use it as is, don't call fd
  if [[ ${QUERY:0:5} == "test/" ]]; then
      mix test $QUERY
      return $?
  fi

  if [[ -z $TEST_DIRS ]]; then
      TEST_DIRS=(`fd test -t d`)
  fi;

  # does this include a line number?
  if test "${QUERY#*:}" != $QUERY; then
      LINE_NUMBER=${QUERY#*:}
      QUERY=${QUERY%%:*}

      # use exs extension since we are looking for a file with this name
      # use -1 to limit to first match
      # use one thread so the output is deterministic
      COMMAND="fd -p $QUERY -e exs -1  --threads 1"
      for DIR in "${TEST_DIRS[@]}"; do
          COMMAND+=" --search-path $DIR"
      done

      FILE=$(eval $COMMAND)
      if [[ -z $FILE ]]; then
          echo "No tests found."
          return 1
      fi
      FILES=$FILE:$LINE_NUMBER
  else
      COMMAND="fd -p $QUERY"
      for DIR in "${TEST_DIRS[@]}"; do
          COMMAND+=" --search-path $DIR"
      done
      FILES=$(eval $COMMAND)
  fi

  if [[ -z $FILES ]]; then
      echo "No tests found."
      return 1
  else
      echo "tests found: \n$FILES\n"
      echo $FILES | xargs mix test
      return $?
  fi
}
