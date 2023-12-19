#!/bin/bash

# install neovim
nix-env -iA nixpkgs.neovim

# install other essential tools
nix-env -iA nixpkgs.fd nixpkgs.ripgrep nixpkgs.fzf nixpkgs.tree

# symlink config files
mkdir /home/gitpod/.config/nvim
rm /home/gitpod/.config/nvim/init.lua

ln -s /home/gitpod/nvim/minimal.lua /home/gitpod/.config/nvim/init.lua
alias vim=nvim
