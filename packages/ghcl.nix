{ pkgs, lib, ... }:

let
  gh = lib.getExe pkgs.gh;
  fzf = lib.getExe pkgs.fzf;
in

pkgs.writeShellScriptBin "ghcl" ''
    ${gh} repo clone "$(${gh} repo list "$@" | ${fzf} | cut -f 1)"
''
