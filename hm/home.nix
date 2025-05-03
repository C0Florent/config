inputs@{ config, pkgs, lib, pkgs-stable, vscode-extensions, ... }:

rec {
  home.username = "fcharpentier";
  home.homeDirectory = "/home/fcharpentier";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    ../packages.nix
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
  ];

  # This ref to pkgs-stable may or may not be relevant.
  home.packages = (with pkgs-stable; [
    # Simple tree directory lister
    tree

    # Clang compiler and associated tools
    clang
    clang-tools

    # CLI tool to unzip zip archives
    unzip

    # FOSS alternative Epic Games launcher: CLI and GUI
    legendary-gl
    rare
    wineWowPackages.waylandFull
  ]) ++ (with pkgs; [
    gh

    wl-clipboard
  ]);

  home.file = {
    ".bash_completion".text = ''
        COMPAL_AUTO_UNMASK=1
        source ${pkgs.complete-alias}/bin/complete_alias
    '';
  };

  home.sessionVariables = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
