{ lib, pkgs, inputs, config, ... }:

let
  cfg = config.mycfg.hyprland;
in
{
  options = {
    mycfg.hyprland = {
      usePackageFromFlake = lib.mkOption {
        type = lib.types.bool;
        description = "Whether to use hyprland package from the flake input; otherwise take from nixpkgs";
        default = false;
      };
    };
  };

  config = {
    programs.hyprland.package = if cfg.usePackageFromFlake
      then inputs.hyprland.packages."${pkgs.system}".hyprland
      else pkgs.hyprland
    ;
  };
}
