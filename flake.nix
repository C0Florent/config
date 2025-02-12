{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    hyprland = {
      url = "github:hyprwm/Hyprland/v0.47.2-b";

      # hyprwm/Hyprland branch v0.47.2-b has an
      # outdated hyprutils input, so we override it here
      inputs.hyprutils.url = "github:hyprwm/hyprutils/v0.5.0";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
      ];

      specialArgs = {
        inherit inputs;
        inherit (inputs) hyprland;

        pkgs-stable = nixpkgs-stable.legacyPackages.${system};
      };
    };
  };
}
