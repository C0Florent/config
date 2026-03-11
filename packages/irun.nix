{
  pkgs,
  skim,
  ...
}:

let
  sk = pkgs.lib.getExe skim;
in

pkgs.writeShellScriptBin "irun" ''
  IFS= read -d "" -r HELP <<"EOF"
  USAGE: irun COMMAND OPTIONS... -- ARGS...

  irun will run COMMAND with OPTIONS passed as argument, and will prompt
  for interactive selection of ARGS.
  The selected arguments which will then also be passed to COMMAND after OPTIONS.

  EXAMPLE:
  irun printf '<%s>\n' -- *
  EOF

  if [[ "$1" = "--help" ]]; then
  echo "''${HELP//irun/"$0"}"
  exit
  fi

  cmd=("$1")
  shift

  while [[ $# != 0 ]]; do
  if [[ "$1" = "--" ]]; then
  shift
  break
  fi
  cmd+=("$1")
  shift
  done

  if [[ $# = 0 ]]; then
  echo >&2 '0 arguments passed, use a -- to separate args'
  exit 1
  fi

  args=()
  while read -r -d ""; do
  args+=("$REPLY")
  done < <(printf '%s\0' "$@" | ${sk} --read0 --print0 --multi '--pre-select-pat=.*')

  printf '%q ' "''${cmd[@]}" "''${args[@]}"; echo
  "''${cmd[@]}" "''${args[@]}"
''
