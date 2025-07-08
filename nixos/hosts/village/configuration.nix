# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [ #notdef
    ./hardware-configuration.nix

    ../../hyprland.nix
    ../../registry.nix
    ../../nerdfonts.nix
  ];

  mycfg.sanedefaults.enable = true;

  time.timeZone = "Europe/Paris"; #def?

  i18n = { #def?
    defaultLocale = "en_GB.UTF-8"; #notdef

    extraLocaleSettings = { #def?
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

  console.keyMap = "fr"; # def?

  users.users.fcharpentier = { #notdef
    isNormalUser = true;
    description = "Florent Charpentier";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  environment.systemPackages = with pkgs; [
    gh #def?

    lua5_4 #notdef

    ghc #def?
  ];

  virtualisation.docker.enable = true; #def?

  system.stateVersion = "25.05"; #notdef
}
