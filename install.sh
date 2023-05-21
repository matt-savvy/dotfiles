#!/bin/bash
nix-channel --update
nix-env -iA nixpkgs.neovim \
nixpkgs.vimPlugins.vim-plug \
nixpkgs.tldr \
nixpkgs.ripgrep \
nixpkgs.gh \
nixpkgs.fd \
nixpkgs.fzf \
nixpkgs.elixir_1_14 \
nixpkgs.nodejs \
nixpkgs.flyctl \
nixpkgs.colordiff \
nixpkgs.tree \
nixpkgs.elmPackages.elm \
nixpkgs.elmPackages.elm-test \
nixpkgs.elmPackages.elm-format

