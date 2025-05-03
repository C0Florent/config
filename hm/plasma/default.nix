{ pkgs, lib, plasma-manager, ... }:

{
  imports = [
    plasma-manager.homeManagerModules.plasma-manager
    ./plasma.nix
  ];
}
