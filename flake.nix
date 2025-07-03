{
  description = ''
    Nix configuration of Florent Charpentier@C0Florent@_Resh

    This single flake contains both a NixOS configuration for my laptop
    as well as a standalone home-manager configuration for my user.

    See more details in README.md
  '';

  inputs = {
    # Input from nixos-unstable by default, to
    # stay up to date with latest software
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Input from the latest stable release for
    # some software which should be kept stable
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Input from hyprland's flake to get the reproducible build
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.49.0";
      inputs.nixpkgs.follows = "nixpkgs";
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
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-stable,
    nix-vscode-extensions,
    ...
  }@inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-stable = nixpkgs-stable.legacyPackages.${system};
    vscode-extensions = nix-vscode-extensions.extensions.${system};
    mylib = import ./mylib.nix { inherit (pkgs) lib; };

    mypkgs = pkgs.lib.packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      directory = ./packages;
    };

    spArgs = {
      inherit inputs pkgs-stable mylib mypkgs;
    };
  in {
    # NixOS configuration
    nixosConfigurations.lahp = nixpkgs.lib.nixosSystem rec {
      inherit system;
      modules = [ ./nixos/configuration.nix ];

      specialArgs = spArgs;
    };

    # Home-manager configuration
    homeConfigurations."fcharpentier" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [ ./hm/home.nix ];

      extraSpecialArgs = spArgs // {
        inherit vscode-extensions;
      };
    };

    packages = mypkgs;
  };
}
