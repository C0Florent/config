{ pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ./plasma.nix
  ];
}
