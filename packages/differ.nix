{ pkgs, lib, ... }:

let
  delta = lib.getExe pkgs.delta;
  wl-paste = lib.getExe' pkgs.wl-clipboard "wl-paste";

  show-copied = ''
    lines='n/a'; words='n/a'; bytes='n/a'
    read lines words bytes < <(wl-paste | wc -l -w -m)
    echo $'\e[3;37m copied!\e[0m'" ($lines lines, $words words)"
  '';
in

pkgs.writeShellScriptBin "differ" ''
    cd /tmp

    if [ "$1" = "--again" ]; then
      echo 'Repeating same diff as last invocation:'
      shift
    else
      echo -n $'Put \e[31mactual\e[0m output in clipboard and press enter...'
      read
      ${wl-paste} > actual
      ${show-copied}

      echo -n $'Put \e[32mexpected\e[0m output in clipboard and press enter...'
      read
      ${wl-paste} > expected
      ${show-copied}
    fi

    ${delta} actual expected "$@" && echo $'\n== \e[3;37mExact match!\e[0m =='
''
