{ ... }:

{
  imports = [
    ./conf.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./monitors.nix
    ./animations.nix
    ./dwindle.nix
    ./cursor.nix

    ./modules/superbinds.nix
    ./superbinds.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    # As the doc says, disable the HM package when using Hyprland from NixOS
    package = null;
    systemd.variables = [ "--all" ];
  };
}
