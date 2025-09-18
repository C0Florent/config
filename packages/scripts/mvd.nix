{pkgs, ...}:

let
  sk = pkgs.lib.getExe pkgs.skim;
in

pkgs.writeShellScriptBin "mvd" ''
    if [ $# -eq 0 ]; then
        echo 'Expecting destination folder' >&2
        exit 1
    fi

    sel=()
    while read -r -d ""; do
      sel+=(~/"Downloads/$REPLY")
    done < <(ls --zero -t ~/Downloads | ${sk} --read0 --print0 --multi)

    if [ ''${#sel} -eq 0 ]; then
        echo 'No file selected, exiting' >&2
        exit 1;
    fi

    echo -n mv; printf ' %q' "''${sel[@]}" "$@"; echo
    mv "''${sel[@]}" "$@"
''
