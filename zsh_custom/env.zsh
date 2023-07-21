export npm_config_fund=false

export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTCONTROL=ignoreboth:erasedups

export PATH="/usr/local/opt/mongodb-community@4.2/bin:$PATH"

# gh cli
export GH_EDITOR="nvim"

# elixir
export ERL_AFLAGS="-kernel shell_history enabled"
export KERL_BUILD_DOCS="yes"

# Nix
# From https://github.com/NixOS/nix/issues/3616
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

export RPS1=''
