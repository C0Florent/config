{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../hyprland.nix
    ../../registry.nix
    ../../nerdfonts.nix
  ];

  mycfg.sanedefaults.enable = true;

  time.timeZone = "Europe/Paris";

  i18n = {
    defaultLocale = "en_GB.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
  };

  console.keyMap = "fr";

  users.users.fcharpentier = {
    isNormalUser = true;
    description = "Florent Charpentier";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    gh
    ghc
  ];

  system.stateVersion = "25.05";
}
