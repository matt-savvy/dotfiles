{
  description = "My NIXOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    home-manager = {
      url =  "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-darwin, home-manager, ...}@inputs: {
    nixosConfigurations.thinkpad-x13 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/thinkpad/x13-hardware-configuration.nix
        ./hosts/thinkpad/configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.matt = import ./hosts/thinkpad/home.nix;
        }
      ];
    };

    nixosConfigurations.thinkpad-x260 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/thinkpad/x260-hardware-configuration.nix
        ./hosts/thinkpad/configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.matt = import ./hosts/thinkpad/home.nix;
        }
      ];
    };

    homeConfigurations."matt.savoia" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs-darwin.legacyPackages."aarch64-darwin";
      modules = [ ./hosts/macbook_pro_thescore/home.nix ];
    };
  };
}
