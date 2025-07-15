{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../hyprland.nix
    ../../registry.nix
    ../../nerdfonts.nix
  ];

  # Enable my sane defaults, which enables all options to
  # to have a working desktop, with some packages I like
  mycfg.sanedefaults.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  time.timeZone = "Australia/Melbourne";
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

  specialisation = {
    no-plasma.configuration = {
      services.desktopManager.plasma6.enable = false;
    };
  };

  services.xserver.xkb = {
    layout = "fr";
    variant = "oss";
  };

  console.keyMap = "fr";

  users.users.fcharpentier = {
    isNormalUser = true;
    description = "Florent Charpentier";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # Many other packages are already included by sanedefaults
  environment.systemPackages = with pkgs; [
    ghc
    valgrind
  ];

  virtualisation.docker.enable = true;

  system.stateVersion = "24.05";
}
