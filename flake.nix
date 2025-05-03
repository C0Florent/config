{
  description = "Home Manager configuration of fcharpentier";

  inputs = {
    # The "standard" nixpkgs which is used for modules which
    # don't need frequent updates, and are ok staying with older versions
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.11";
    };

    # The "cutting-edge" nixpkgs, used by modules that always
    # want the latest version of everything.
    nixpkgs-latest = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixpkgs-latest, nix-vscode-extensions, plasma-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-latest = nixpkgs-latest.legacyPackages.${system};
      vscode-extensions = nix-vscode-extensions.extensions.${system};
    in {
      homeConfigurations."fcharpentier" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./hm/home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          inherit pkgs-latest vscode-extensions plasma-manager;
          mylib = import ./mylib.nix { inherit (pkgs) lib; };
        };
      };
    } // pkgs.lib.packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      directory = ./packages;
    };
}
