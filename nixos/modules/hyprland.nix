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
      debug = lib.mkOption {
        type = lib.types.bool;
        description = "Whether to use a debug build. Only works with usePackageFromFlake turned on";
        default = false;
      };
    };
  };

  config = let
    hyprpkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    warnings = lib.optional
      (!(cfg.debug -> cfg.usePackageFromFlake))
      "mycfg.hyprland.debug only works with usePackageFromFlake turned on"
    ;

    programs.hyprland = lib.optionalAttrs cfg.usePackageFromFlake {
      package = if cfg.debug
        then hyprpkgs.hyprland-debug
        else hyprpkgs.hyprland
      ;
      portalPackage = hyprpkgs.xdg-desktop-portal-hyprland;
    };
  };
}
