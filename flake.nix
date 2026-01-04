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
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Input from hyprland's flake to get the reproducible build
    hyprland = {
      url = "github:hyprwm/hyprland/v0.53.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    home-manager = {
      url = "github:C0Florent/home-manager/hyprland-animations";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    unspace = {
      url = "github:C0Florent/unspace";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    nix-vscode-extensions,
    ...
  }@inputs: let
    mapSystems = nixpkgs.lib.genAttrs [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];
    # Runs a function which takes pkgs from nixpkgs unstable for all systems,
    # returning an attrset of systems where the function has been applied for
    # all systems
    # (pkgs -> a) -> { <system> = a; }
    forAllSystems = f: mapSystems (system: f nixpkgs.legacyPackages.${system});

    # Run a function which takes several "forAllSystems" attributes
    # { <name>.<system> = a; } -> ({ <name> = a; } -> b) -> { <system> = b; }
    mapAttrsSystems = attrs: f:
      mapSystems (system: f (builtins.mapAttrs (n: v: v.${system}) attrs))
    ;

    mylib = import ./mylib.nix { inherit (nixpkgs) lib; };

    nvf = forAllSystems (pkgs: inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [ ./nvf ];
    });

    mypkgs = forAllSystems (pkgs: pkgs.lib.packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      directory = ./packages;
    });

    spArgs = mapAttrsSystems
      {
        pkgs-stable = nixpkgs-stable.legacyPackages;
        inherit mypkgs;
      }
      ({ pkgs-stable, mypkgs }: {
        inherit inputs pkgs-stable mylib mypkgs;
      })
    ;
  in {
    # Read all NixOS hosts from ./nixos/hosts using a custom function from mylib
    nixosConfigurations = mylib.readNixOSHosts {
      inherit (nixpkgs.lib) nixosSystem;

      hostsDirPath = ./nixos/hosts;
      args = ({ system }: {
        specialArgs = spArgs.${system};
      });
    };

    # Home-manager configuration
    homeConfigurations = mapAttrsSystems
      {
        inherit spArgs nvf;
        pkgs = nixpkgs.legacyPackages;
        vscode-extensions = nix-vscode-extensions.extensions;
      }
      ({ pkgs, vscode-extensions, nvf, spArgs }: {
          fcharpentier = inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            modules = [ ./hm/home.nix ];

            extraSpecialArgs = spArgs // {
              inherit vscode-extensions nvf;
            };
          };
        }
      )
    ;

    legacyPackages = mapAttrsSystems
      { inherit (self) homeConfigurations; }
      ({ homeConfigurations }: {
        inherit homeConfigurations;
      })
    ;

    packages = mapAttrsSystems
      { inherit mypkgs nvf; inherit (self) homeConfigurations; }
      ({ mypkgs, nvf, homeConfigurations }: mypkgs // {
        nvf = nvf.neovim;
      })
    ;
  };
}
