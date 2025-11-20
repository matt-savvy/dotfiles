export npm_config_fund=false

export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTCONTROL=ignoreboth:erasedups

export PATH="$PATH:~/.local/bin"

# gh cli
export GH_EDITOR="nvim"
export EDITOR="nvim"

# elixir
export ERL_AFLAGS="-kernel shell_history enabled"
export KERL_BUILD_DOCS="yes"

# Nix
# From https://github.com/NixOS/nix/issues/3616
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

export RPS1=''

# from https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key#telling-git-about-your-gpg-key
export GPG_TTY=$(tty)
