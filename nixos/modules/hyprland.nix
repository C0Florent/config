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
    programs.hyprland = let
      hyprpkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
    in lib.optionalAttrs cfg.usePackageFromFlake {
      package = hyprpkgs.hyprland;
      portalPackage = hyprpkgs.xdg-desktop-portal-hyprland;
    };
  };
}
