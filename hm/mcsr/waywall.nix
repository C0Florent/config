{ pkgs, lib, config, mypkgs, ... }:

let
  hyprconfig = config.wayland.windowManager.hyprland;
in
{
  home.packages = with pkgs; [
    waywall
  ];

  xdg.configFile."waywall/init.lua".source = ./waywall.lua;
  xdg.configFile."waywall/nix.lua".text = ''return ${lib.generators.toLua {} {
    inherit (hyprconfig.settings) input;
    background = ../hypr/assets/background.png;
    eye_overlay = ./eye_overlay.png;
    nbb = lib.getExe mypkgs.nbb;
  }}'';
}
