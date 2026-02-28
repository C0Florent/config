{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../hyprland.nix
    ../../registry.nix
    ../../nerdfonts.nix

    ./nodebounce.nix

    ./monash
  ];

  # Enable my sane defaults, which enables all options to
  # to have a working desktop, with some packages I like
  mycfg.sanedefaults.enable = true;
  mycfg.hyprland.usePackageFromFlake = true;
  mycfg.hyprland.debug = false; # switch to true to use a debug build

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernel.sysctl = {
    # allow all SysRq sequences to be used
    "kernel.sysrq" = 1;
  };

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

  # turn off plasma (which is enabled by sanedefaults), lahp is full-on hyprland
  services.desktopManager.plasma6.enable = false;

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
