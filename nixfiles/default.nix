{ config, pkgs, lib, nixpkgs-unstable, ... }:

{
  options = { hardMode = lib.mkEnableOption "hardMode"; };
  config = {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = with pkgs; [
      colordiff
      xclip
      asciinema
      fd
      # flyctl
      fzf
      fswatch
      gh
      ## golang
      go
      gotools
      go-tools
      cobra-cli
      sqlite
      lua51Packages.lua
      ## haskell
      ghc
      shellcheck
      ripgrep
      tldr
      tree
      # gleam
      beam.packages.erlang_27.erlang
      beam.packages.erlang_27.elixir_1_18
      (beam.packages.erlang_27.elixir-ls.override {
        elixir = beam.packages.erlang_27.elixir_1_18;
      })
      beam.packages.erlang_27.rebar3
      elmPackages.elm
      elmPackages.elm-test
      elmPackages.elm-format
      elmPackages.elm-language-server
      nodejs
      deno
      nixpkgs-unstable.zig
      docker
      docker-compose
      postgresql
      colima
      oath-toolkit
      rlwrap
      imagemagick
    ];


    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
      ".gitignore".source = ../git/.gitignore;
      ".config/kitty/Terafox.conf".source = ../kitty/terafox_kitty.conf;
      ".iex.exs".source = ../.iex.exs;
      ".cobra.yaml".source = ../cobra.yaml;
    };

    # You can also manage environment variables but you will have to manually
    # source
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/mattsavoia/etc/profile.d/hm-session-vars.sh
    #
    # if you don't want to manage your shell through Home Manager.
    home.sessionVariables = {
      # EDITOR = "emacs";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    programs.git = {
      enable = true;
      includes = [{ path = ../git/.gitconfig; }];
    };

    home.sessionPath = [
      "$HOME/.local/bin"
    ];

    programs.neovim = lib.mkMerge [{
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
      plugins = with pkgs.vimPlugins; [
        # Deletes trailing whitespace on buffer write
        vim-better-whitespace
        # Allows for easy commenting out of lines and motions
        vim-commentary
        # Needed for telescope
        plenary-nvim
        # Fuzzy finder
        telescope-nvim
        telescope-fzy-native-nvim
        # Grep within working dir or repo
        vim-grepper
        # nightfox theme
        nightfox-nvim
      ];
    }
      # hardmode config
      (lib.mkIf config.hardMode {
        extraLuaConfig = builtins.readFile (../nvim/hardmode.lua);
      })
      # normal config
      (lib.mkIf (!config.hardMode) {
        extraLuaConfig = builtins.readFile (../nvim/init.lua);
        plugins = with pkgs.vimPlugins; [
          # Allows changing the surrounding chars of a string with cs
          vim-surround
          # Allows for easy commenting out of lines and motions
          vim-repeat
          # Git integration
          vim-fugitive
          # Quickstart configs for Nvim LSP
          nvim-lspconfig
          # Nix syntax
          vim-nix
          # Elixir syntax
          vim-elixir
          # Graphql syntax
          vim-graphql
          # Gleam
          gleam-vim
          # Go
          vim-go
          # test runner
          vim-test
          dhall-vim
        ];
      })];

    programs.zsh = {
      enable = true;
      autocd = false;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "robbyrussell";
        custom = "$HOME/dev/dotfiles/zsh_custom/";
      };
    };

    programs.kitty = {
      enable = true;
      extraConfig = builtins.readFile (../kitty/kitty.conf);
    };

    programs.gpg = {
      enable = true;
    };
  };
}
