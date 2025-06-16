{ pkgs, lib, inputs, ... }:

{
  imports = [
    ./modules/hyprland.nix
  ];

  programs.hyprland = {
    enable = lib.mkDefault true;
    xwayland.enable = true;

    withUWSM = true;
  };

  mycfg.hyprland = {
    usePackageFromFlake = false;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
