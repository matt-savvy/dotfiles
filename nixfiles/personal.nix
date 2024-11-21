{ config, pkgs, ... }:

{
  imports = [ ./home.nix ];

  home.packages = with pkgs; [
    inotify-tools
    gdb
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mattsavoia";
  home.homeDirectory = "/home/mattsavoia";
}
