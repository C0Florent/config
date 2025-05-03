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
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    # Input from hyprland's flake to get the reproducible build
    hyprland.url = "github:hyprwm/Hyprland/v0.48.1-b";

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11"; # change to main in next commit
      inputs.nixpkgs.follows = "nixpkgs-stable"; # remove this -stable in next commit
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
  in {
    # NixOS configuration
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];

      specialArgs = {
        inherit inputs;
        inherit (inputs) hyprland;

        pkgs-stable = nixpkgs-stable.legacyPackages.${system};
      };
    };

    # Home-manager configuration
    homeConfigurations."fcharpentier" = inputs.home-manager.lib.homeManagerConfiguration {
      # change the stable/latest pkgs management in next commit
      pkgs = pkgs-stable;

      modules = [ ./hm/home.nix ];

      extraSpecialArgs = {
        inherit vscode-extensions;
        inherit (inputs) plasma-manager;
        
        pkgs-latest = pkgs;
        mylib = import ./mylib.nix { inherit (pkgs-stable) lib; };
      };
    };
  } // pkgs.lib.packagesFromDirectoryRecursive {
    inherit (pkgs) callPackage;
    directory = ./packages;
  };
}
# {
# <<<<<<< HEAD
#   description = "Home Manager configuration of fcharpentier";
# 
#   inputs = {
#     # The "standard" nixpkgs which is used for modules which
#     # don't need frequent updates, and are ok staying with older versions
#     nixpkgs = {
#       url = "github:nixos/nixpkgs/nixos-24.11";
#     };
# 
#     # The "cutting-edge" nixpkgs, used by modules that always
#     # want the latest version of everything.
#     nixpkgs-latest = {
#       url = "github:nixos/nixpkgs/nixos-unstable";
#     };
# 
#     nix-vscode-extensions = {
#       url = "github:nix-community/nix-vscode-extensions";
#     };
# 
#     plasma-manager = {
#       url = "github:nix-community/plasma-manager";
#       inputs.nixpkgs.follows = "nixpkgs";
#       inputs.home-manager.follows = "home-manager";
#     };
# 
#     home-manager = {
#       url = "github:nix-community/home-manager/release-24.11";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
#   };
# 
#   outputs = { nixpkgs, home-manager, nixpkgs-latest, nix-vscode-extensions, plasma-manager, ... }:
#     let
#       system = "x86_64-linux";
#       pkgs = nixpkgs.legacyPackages.${system};
#       pkgs-latest = nixpkgs-latest.legacyPackages.${system};
#       vscode-extensions = nix-vscode-extensions.extensions.${system};
#     in {
#       homeConfigurations."fcharpentier" = home-manager.lib.homeManagerConfiguration {
#         inherit pkgs;
# 
#         # Specify your home configuration modules here, for example,
#         # the path to your home.nix.
#         modules = [ ./hm/home.nix ];
# 
#         # Optionally use extraSpecialArgs
#         # to pass through arguments to home.nix
#         extraSpecialArgs = {
#           inherit pkgs-latest vscode-extensions plasma-manager;
#           mylib = import ./mylib.nix { inherit (pkgs) lib; };
#         };
#       };
#     } // pkgs.lib.packagesFromDirectoryRecursive {
#       inherit (pkgs) callPackage;
#       directory = ./packages;
#     };
# =======
#   description = "A simple NixOS flake";
# 
#   inputs = {
#     nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
# 
#     nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
# 
#     hyprland.url = "github:hyprwm/Hyprland/v0.48.1-b";
#   };
# 
#   outputs = { self, nixpkgs, nixpkgs-stable, ... }@inputs: {
#     # Please replace my-nixos with your hostname
#     nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
#       system = "x86_64-linux";
#       modules = [
#         # Import the previous configuration.nix we used,
#         # so the old configuration file still takes effect
#         ./configuration.nix
#       ];
# 
#       specialArgs = {
#         inherit inputs;
#         inherit (inputs) hyprland;
# 
#         pkgs-stable = nixpkgs-stable.legacyPackages.${system};
#       };
#     };
#   };
# >>>>>>> old-nixos/main
# }
