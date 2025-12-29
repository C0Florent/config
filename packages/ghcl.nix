{pkgs, ...}:

let
  gh = "${pkgs.gh}/bin/gh";
  fzf = "${pkgs.fzf}/bin/fzf";
in

pkgs.writeShellScriptBin "ghcl" ''
    ${gh} repo clone "$(${gh} repo list "$@" | ${fzf} | cut -f 1)"
''
