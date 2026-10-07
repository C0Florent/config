{ pkgs, lib, ... }:

{
  fonts.packages = with pkgs.nerd-fonts; [
    martian-mono
  ];
}
