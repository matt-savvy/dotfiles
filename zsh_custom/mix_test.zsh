#!/bin/zsh

function mix_test() {
  QUERY=$1
  TEST_DIRS=($(fd ^test$ -t d))

  # no query
  if [[ -z $QUERY ]]; then
    mix test
    return $?
  fi

  # if the query is an existing file, just run it as is
  if [[ -e $QUERY ]]; then
      mix test $QUERY
      return $?
  fi

  # does this include a line number? run it as is
  if test "${QUERY#*:}" != $QUERY; then
      echo "line number"
      mix test $QUERY
      return $?
  else
      # .exs files matching query
      COMMAND="fd $QUERY -e exs"
      for DIR in "${TEST_DIRS[@]}"; do
          COMMAND+=" --search-path $DIR"
      done
      FILES=$(eval $COMMAND)

      # dirs matching query
      COMMAND="fd $QUERY --type directory"
      for DIR in "${TEST_DIRS[@]}"; do
          COMMAND+=" --search-path $DIR"
      done
      DIRS=$(eval $COMMAND)
  fi

  if [[ -z $FILES && -z $DIRS ]]; then
      echo "No tests found."
      return 1
  else
      echo "tests found: \n$FILES\n$DIRS\n"
      echo $FILES $DIRS | xargs mix test
      return $?
  fi
}
