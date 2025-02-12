{ pkgs, lib, hyprland, ... }:

{
  programs.hyprland = {
    enable = lib.mkDefault true;
    package = hyprland.packages."${pkgs.system}".hyprland;

    withUWSM = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
