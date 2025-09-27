{ pkgs, lib , ... }:

{
  programs.git = {
    enable = true;

    userName = "Florent Charpentier";
    userEmail = "florent.charpentier@epitech.eu";

    signing = {
      signByDefault = true;
      format = "openpgp";
    };
  };
}
