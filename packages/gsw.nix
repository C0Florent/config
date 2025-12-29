{pkgs, ...}:

let
  fzf = "${pkgs.fzf}/bin/fzf";
  xargs = "${pkgs.toybox}/bin/xargs";
in

pkgs.writeShellScriptBin "gsw" ''
    if [ $# -ne 0 ]; then
        git switch "$@"
        exit $?
    fi
    current_branch="$(git branch --show-current)"
    if [ -z $current_branch ]; then
        exit 1;
    fi

    echo
    echo 'Select a branch with fzf, or press ESC or ^C to exit'
    
    chosen_branch="$((echo "$current_branch"; git branch | grep -v "^\* $current_branch\$") | ${fzf} '--height=~50%')"

    printf '\e[A\e[K'

    if [ -z "$chosen_branch" ]; then
        printf '\e[A\e[K'
        exit 1;
    fi
    
    git switch "$(${xargs} <<< "$chosen_branch")"
    exit $?
''
