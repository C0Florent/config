{ pkgs, lib, ... }:

{
  programs.hyprland = {
    enable = lib.mkDefault true;

    withUWSM = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
