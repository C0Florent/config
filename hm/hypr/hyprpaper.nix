{ pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;

    settings = {
      "$background" = "${./assets/background.png}";

      preload = [
        "$background"
      ];

      wallpaper = [
        ", $background"
      ];

      splash = false;
    };
  };
}
