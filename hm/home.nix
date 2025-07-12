inputs@{ config, pkgs, lib, pkgs-stable, vscode-extensions, ... }:

rec {
  home.username = "fcharpentier";
  home.homeDirectory = "/home/fcharpentier";

  imports = [
    ./packages.nix
    ./shell/bash.nix
    ./shell/nu.nix
    ./shell/starship.nix
    ./shell/readline.nix
    ./alacritty.nix
    ./vscode.nix
    ./kitty.nix
    ./eza.nix
    ./bat.nix
    ./btop
    ./lazygit.nix
    ./delta.nix
    ./plasma
    ./hypr
    ./wezterm.nix
    ./gtk.nix
    ./git.nix
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "discord"
  ];

  # This ref to pkgs-stable may or may not be relevant.
  home.packages = (with pkgs-stable; [
    # Simple tree directory lister
    tree

    # CLI tool to unzip zip archives
    unzip

    # FOSS alternative Epic Games launcher: CLI and GUI
    legendary-gl
    rare
    wineWowPackages.waylandFull
  ]) ++ (with pkgs; [
    gh # GitHub CLI

    wl-clipboard # CLI clipboard: wl-copy, wl-paste

    discord
    teams-for-linux # Unofficial electron wrapper for the Teams web app
    (mgba.override { lua = pkgs.lua5_4_compat; }) # Override needed for scripts

    obs-studio
  ]);

  home.file = {
    ".bash_completion".text = ''
      COMPAL_AUTO_UNMASK=1
      source ${pkgs.complete-alias}/bin/complete_alias
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
