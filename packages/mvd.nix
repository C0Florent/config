{pkgs, ...}:

let
  sk = pkgs.lib.getExe pkgs.skim;
in

pkgs.writeShellScriptBin "mvd" ''
    help() {
        echo "USAGE: $0 [from [to]]"
        echo "DEFAULT: from ~/Downloads to ."
    }

    if [ $# -gt 2 ]; then
        help >&2
        exit 1
    fi
    if [ "$1" = "--help" ]; then
        help
        exit
    fi

    from=''${1:-~/Downloads}
    to=''${2:-.}

    sel=()
    while read -r -d ""; do
      sel+=("$from/$REPLY")
    done < <(ls --zero -t "$from" | ${sk} --read0 --print0 --multi)

    if [ ''${#sel} -eq 0 ]; then
        echo 'No file selected, exiting' >&2
        exit 1;
    fi

    echo -n mv; printf ' %q' "''${sel[@]}" "$to"; echo
    mv "''${sel[@]}" "$to"
''
