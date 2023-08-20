{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mattsavoia";
  home.homeDirectory = "/home/mattsavoia";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    colordiff
    xclip
    fd
    # flyctl
    fzf
    gh
    ghc
    haskellPackages.cabal-install
    ripgrep
    tldr
    tree
    ghc
    elixir
    elmPackages.elm
    elmPackages.elm-test
    elmPackages.elm-format
    nodejs
    docker
    docker-compose
    colima
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
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
  };

  home.file.".gitconfig".source = ../git/.gitconfig;
  home.file.".gitignore".source = ../git/.gitignore;

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
        (nvim-treesitter.withPlugins (p: [ p.haskell ]))
        # Needed for telescope, harpoon
        plenary-nvim
        # Fuzzy finder
        telescope-nvim
        telescope-fzy-native-nvim
        # Quick buffer/location navigator
        harpoon
        # Grep within working dir or repo
        vim-grepper
        # LSP
        mason-nvim
        mason-lspconfig-nvim
        # Quickstart configs for Nvim LSP
        nvim-lspconfig
        # Nix syntax
        vim-nix
        # Elixir syntax
        vim-elixir
        # Graphql syntax
        vim-graphql
        # Snippets
        luasnip
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
    extraConfig = builtins.readFile(../kitty.conf);
  };

  home.file.".iex".source = ../.iex.exs;
}
