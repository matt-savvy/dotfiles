{
  description = "My NixOS / Home-Manager Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-darwin, nixpkgs-unstable, home-manager, agenix, ... }: {
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
        agenix.nixosModules.default
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
        agenix.nixosModules.default
      ];
    };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;
  };
}
