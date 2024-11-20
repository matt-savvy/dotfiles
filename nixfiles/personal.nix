{ config, pkgs, ... }:

{
  imports = [ ./home.nix ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mattsavoia";
  home.homeDirectory = "/home/mattsavoia";
}
