{ pkgs, lib, inputs, ... }:

{
  programs.hyprland = {
    enable = lib.mkDefault true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;

    withUWSM = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
