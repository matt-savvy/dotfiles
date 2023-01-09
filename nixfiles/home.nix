{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "matt";
  home.homeDirectory = "/Users/matt";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
      custom = "$HOME/dev/dotfiles/zsh_custom";
    };
  };

  home.packages = with pkgs; [
    tldr
    ripgrep
    gh
    fd
    erlangR25
    elixir_1_14
    python2
    python311
    nodejs
    elmPackages.elm
    docker
    vimPlugins.vim-plug
  ];

  programs.git = {
    enable = true;
  };

  home.file.".gitconfig".source = ../git/.gitconfig;
  home.file.".gitignore".source = ../git/.gitignore;

  home.file.".iex.exs".source = ../.iex.exs;

  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
    ];
    extraConfig = ''
        luafile ${../nvim/init.lua}
    '';
  };

}
