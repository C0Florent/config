{
  pkgs,
  lib,
  ...
}: {
  programs.git = {
    enable = true;

    settings = {
      user.name = "Florent Charpentier";
      user.email = "florent.charpentier@epitech.eu";
    };

    signing = {
      signByDefault = true;
      format = "openpgp";
    };
  };
}
