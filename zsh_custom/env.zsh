# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export npm_config_fund=false

export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTCONTROL=ignoreboth:erasedups

export PATH="/usr/local/opt/mongodb-community@4.2/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"

## for pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# gh cli
export GH_EDITOR="nvim"

# elixir
export ERL_AFLAGS="-kernel shell_history enabled"

function mix_test() {
  QUERY=$1

  if [[ -z $QUERY ]]; then
    mix test
    return 0
  fi

  # does this include a line number?
  if test "${QUERY#*:}" != $QUERY; then
      LINE_NUMBER=${QUERY#*:}
      QUERY=${QUERY%%:*}
      FILE=`fd -p $QUERY test | head -n 1`
      if [[ -z $FILE ]]; then
          echo "No tests found."
          return 1
      fi
      FILES=$FILE:$LINE_NUMBER
  else
      FILES=`fd -p $QUERY test | head`
  fi

  # if $1 starts with test, use it as is, don't call fd

  if [[ -z $FILES ]]; then
      echo "No tests found."
      return 1
  else
      echo "tests found: \n$FILES\n"
      echo $FILES | xargs mix test
      return 0
  fi
}

