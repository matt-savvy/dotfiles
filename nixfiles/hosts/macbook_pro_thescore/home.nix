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
      { path = ../../../git/thescoreconfig; }
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
    (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
  ];

  nixpkgs.config.allowUnfree = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    mise = { enable = true; };
  };

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };

  home.stateVersion = "24.11";
}
