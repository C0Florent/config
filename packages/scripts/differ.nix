{ pkgs, ... }:

let
  delta = "${pkgs.delta}/bin/delta";
  wl-paste = "${pkgs.wl-clipboard}/bin/wl-paste";

  show-copied = ''
    lines='n/a'; words='n/a'; bytes='n/a'
    read lines words bytes < <(wl-paste | wc -l -w -m)
    echo $'\e[3;37m copied!\e[0m'" ($lines lines, $words words)"
  '';
in

pkgs.writeShellScriptBin "differ" ''
    cd /tmp

    echo -n $'Put \e[31mactual\e[0m output in clipboard and press enter...'
    read
    ${wl-paste} > actual
    ${show-copied}

    echo -n $'Put \e[32mexpected\e[0m output in clipboard and press enter...'
    read
    ${wl-paste} > expected
    ${show-copied}

    ${delta} actual expected && echo $'\n== \e[3;37mExact match!\e[0m =='
''
