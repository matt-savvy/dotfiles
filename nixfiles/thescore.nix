{ config, pkgs, ... }:

{
  imports = [ ./home.nix ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "matt.savoia";
  home.homeDirectory = "/Users/matt.savoia";

  programs.git = {
    userEmail = "matt.savoia@thescore.com";
    signing = {
      key = "41C98C98CC1DB00C";
      signByDefault = true;
    };
    extraConfig = {
      credential = {
        helper = "osxkeychain";
      };
    };
    includes = [
      { path = ../git/.gitconfig; }
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
  };

}
