{ config, pkgs, ... }:

{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  nix = {
    package = pkgs.nix;
    settings.experimental-features = ["nix-command" "flakes"];
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    colordiff
    xclip
    inotify-tools
    asciinema
    fd
    gdb
    util-linux
    # flyctl
    fzf
    fswatch
    gh
    # golang
    go
    gotools
    go-tools
    cobra-cli
    sqlite
    lua51Packages.lua
    # haskell
    ghc
    stack
    haskellPackages.fourmolu
    # haskellPackages.haskell-language-server
    shellcheck
    ripgrep
    tldr
    tree
    gleam
    beam.packages.erlang_27.erlang
    beam.packages.erlang_27.elixir_1_17
    beam.packages.erlang_27.elixir-ls
    beam.packages.erlang_27.rebar3
    elmPackages.elm
    elmPackages.elm-test
    elmPackages.elm-format
    elmPackages.elm-language-server
    nodejs
    deno
    docker
    docker-compose
    postgresql
    colima
    oath-toolkit
    rlwrap
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
    includes = [ { path = ../git/.gitconfig; } ];
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

 #  programs.neovim = {
 #    enable = true;
 #    extraLuaConfig = builtins.readFile(../nvim/hardmode.lua);
 #    defaultEditor = true;
 #    vimAlias = true;
 #    plugins = with pkgs.vimPlugins; [
 #        # Deletes trailing whitespace on buffer write
 #        vim-better-whitespace
 #        # Allows for easy commenting out of lines and motions
 #        vim-commentary
 #        # Needed for telescope
 #        plenary-nvim
 #        # Fuzzy finder
 #        telescope-nvim
 #        telescope-fzy-native-nvim
 #        # Grep within working dir or repo
 #        vim-grepper
 #        # nightfox theme
 #        nightfox-nvim
 #    ];
 #  };

 programs.neovim = {
   enable = true;
   extraLuaConfig = builtins.readFile(../nvim/init.lua);
   defaultEditor = true;
   vimAlias = true;
   plugins = with pkgs.vimPlugins; [
        # gruvbox theme
        gruvbox
        # nord theme
        nord-vim
        # tokyo night theme
        tokyonight-nvim
        # nightfox theme
        nightfox-nvim
        # Deletes trailing whitespace on buffer write
        vim-better-whitespace
        # Allows changing the surrounding chars of a string with cs
        vim-surround
        # Allows for easy commenting out of lines and motions
        vim-commentary
        # Allows . command to repeat plugin actions
        vim-repeat
        # Git integration
        vim-fugitive
        # treesitter configs and abstraction layer
        # (nvim-treesitter.withPlugins (p: [ p.haskell p.lua ]))
        # Needed for telescope, harpoon
        plenary-nvim
        # Fuzzy finder
        telescope-nvim
        telescope-fzy-native-nvim
        # Quick buffer/location navigator
        harpoon
        # Grep within working dir or repo
        vim-grepper
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
        # Snippets
        luasnip
        # test runner
        vim-test
      ];
      withNodeJs = true;
      withPython3 = true;
    };

  programs.zsh = {
     enable = true;
     autocd = false;
     oh-my-zsh = {
         enable = true;
         plugins = ["git"];
         theme = "robbyrussell";
         custom = "$HOME/dev/dotfiles/zsh_custom/";
     };
  };

  programs.kitty = {
    enable = true;
    extraConfig = builtins.readFile(../kitty/kitty.conf);
  };

  programs.gpg = {
    enable = true;
  };
}
