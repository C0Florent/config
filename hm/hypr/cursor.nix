{ pkgs, ... }:

let
  name = "Bibata-Modern-Classic";
  size = 20;
in
{
  gtk = {
    enable = true;

    cursorTheme = {
      package = pkgs.bibata-cursors;
      inherit name size;
    };
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "hyprctl setcursor ${name} ${builtins.toString size}"
    ];
  };
}
