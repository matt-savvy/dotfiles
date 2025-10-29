{ config, pkgs, ... }:

{
  nix.package = pkgs.nix;

  imports = [ ../../default.nix ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "matt.savoia";
  home.homeDirectory = "/Users/matt.savoia";

  programs.git = {
    includes = [
      {
        condition = "gitdir:~/scorebet/";
        path = ../../../git/thescoreconfig;
      }
      {
        condition = "gitdir:~/scoremedia/";
        path = ../../../git/thescoreconfig;
      }
    ];
  };

  home.packages = with pkgs; [
    argocd
    jq
    openssl
    protobuf
    prototool
    kubernetes-helm
    pinentry_mac
    k9s
    kubectl
    kubectx
    vault
    buf
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
  ];

  nixpkgs.config.allowUnfree = true;

  programs.kitty = {
    extraConfig = ''
      font_size 14.0
      # Jump by word
      map alt+left send_text all \x1b\x62
      map alt+right send_text all \x1b\x66
    '';
  };

  programs.direnv = {
    mise = { enable = true; };
  };

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };

  home.stateVersion = "24.11";
}
