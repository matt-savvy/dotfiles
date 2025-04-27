{
  description = "My NixOS / Home-Manager Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url =  "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-darwin, nixpkgs-unstable, home-manager, ...}: {
    nixosConfigurations.thinkpad-x13 = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        ./hosts/thinkpad/x13-hardware-configuration.nix
        ./hosts/thinkpad/configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.matt = ./hosts/thinkpad/home.nix;
          home-manager.extraSpecialArgs = {
            nixpkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
          };
        }
      ];
    };

    nixosConfigurations.thinkpad-x260 = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        ./hosts/thinkpad/x260-hardware-configuration.nix
        ./hosts/thinkpad/configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.matt = ./hosts/thinkpad/home.nix;
          home-manager.extraSpecialArgs = {
            nixpkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
          };
        }
      ];
    };

    homeConfigurations."matt.savoia" = let
      system = "aarch64-darwin";
    in
    home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs-darwin.legacyPackages.${system};
      modules = [ ./hosts/macbook_pro_thescore/home.nix ];
      extraSpecialArgs = {
        nixpkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      };
    };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
}
