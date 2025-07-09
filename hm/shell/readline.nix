{ pkgs, lib, ... }:

{
  # We add packages to environment rather than use strict
  # nix store paths because the executed command will be
  # printed on screen, and store paths are ugly
  home.packages = with pkgs; [
    wl-clipboard # for wl-paste
    moreutils    # for vipe
  ];

  programs.readline = {
    enable = true;

    bindings = {
      # Based on this example: https://stackoverflow.com/q/4200800/
      "\\ev" = ''"\C-k \C-ueval \"$(wl-paste | vipe --suffix sh | tee >(wl-copy -n))\"\n"'';
    };
  };
}
