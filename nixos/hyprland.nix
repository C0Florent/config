{ pkgs, lib, inputs, ... }:

{
  programs.hyprland = {
    enable = lib.mkDefault true;
    xwayland.enable = true;

    withUWSM = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
