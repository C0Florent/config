{ pkgs, lib, ... }:

{
  services.hyprpaper = {
    enable = true;

    settings = {
      "$background" = "${./assets/background.png}";

      wallpaper = {
        monitor = "";
        path = "$background";
      };

      splash = false;
    };
  };
}
