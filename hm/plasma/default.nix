{ pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
    ./plasma.nix
  ];
}
