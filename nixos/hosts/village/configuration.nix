# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [ #notdef
    ./hardware-configuration.nix

    ../../hyprland.nix
    ../../registry.nix
  ];

  boot.loader.systemd-boot.enable = true; #def?
  boot.loader.efi.canTouchEfiVariables = true; #def?
  boot.kernelPackages = pkgs.linuxPackages_latest; #def?

  networking.networkmanager.enable = true; #def?

  networking.firewall.allowedUDPPorts = [ 8080 ]; #notdef

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

  services.xserver.enable = true; # def

  services.displayManager.sddm.enable = true; # def

  services.desktopManager.plasma6.enable = lib.mkDefault true; # def

  specialisation = { # notdef
    no-plasma.configuration = {
      services.desktopManager.plasma6.enable = false;
    };
  };

  services.xserver.xkb = { # def
    layout = "fr";
    variant = "oss";
  };

  console.keyMap = "fr"; # def?

  services.printing.enable = true; # def?

  services.pulseaudio.enable = false; #def?
  security.rtkit.enable = true; #def?
  services.pipewire = { #def?
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    jack.enable = true;
  };

  nix.settings.experimental-features = "nix-command flakes pipe-operators"; # def

  users.users.fcharpentier = { #notdef
    isNormalUser = true;
    description = "Florent Charpentier";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  programs.firefox.enable = true; #def?

  programs.git = { # def
    enable = true;

    prompt.enable = true;
    config = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };

  fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts); #def?

  environment.systemPackages = with pkgs; [
    moreutils # def

    vim # def
    neovim #def?
    git # def
    neofetch # def
    gh #def?

    lua5_4 #notdef

    ghc #def?
    valgrind #notdef
    libgccjit #notdef
    gnumake #notdef
    cargo #notdef

    docker #def?
    docker-compose #def?

    stdmanpages # def
    linux-manual # def
    man-pages # def
    vlc # def
  ];

  virtualisation.docker.enable = true; #def?

  programs.neovim.enable = true; #def?
  programs.neovim.defaultEditor = true; #def?

  system.stateVersion = "25.05"; #notdef
}
